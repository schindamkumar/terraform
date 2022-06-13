provider "azurerm" {
  features {}
}

resource "random_integer" "sqldb_id" {
  min     = 1
  max     = 9999
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Create a supporting storage account for SQL Server
# that will be used for SQL auditing and threat detection
resource "azurerm_storage_account" "sql_storage" {
  name                     = "sqlstorage${random_integer.sqldb_id.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.storage_account_type
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
}

resource "azurerm_mssql_server" "example" {
  name                         = "example-sqlserver-${random_integer.sqldb_id.result}"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.sql_ser_ad_login
  administrator_login_password = var.sql_ser_ad_pwd
  minimum_tls_version          = "1.2"

  /*
  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.sql_storage.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.sql_storage.primary_access_key
    storage_account_access_key_is_secondary = false
    retention_in_days                       = 6
  }*/
}

resource "azurerm_mssql_server_extended_auditing_policy" "example" {
  server_id                               = azurerm_mssql_server.example.id
  storage_account_subscription_id         = var.storage_account_sub_id
  storage_endpoint                        = azurerm_storage_account.sql_storage.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.sql_storage.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet-${random_integer.sqldb_id.result}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "example-subnet-${random_integer.sqldb_id.result}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
  enforce_private_link_endpoint_network_policies = true
}

# Allow network traffic to the SQL Server only with resources in the private-subnet 
resource "azurerm_mssql_virtual_network_rule" "sql_network_rule" {
  name                = "sql-network-rule-${random_integer.sqldb_id.result}"
  server_id           = azurerm_mssql_server.example.id
  subnet_id           = azurerm_subnet.private_subnet.id
}

# Allow only Azure Trusted Services to access the SQL Server 
resource "azurerm_mssql_firewall_rule" "sql_firewall_rule" {
  name                = "sql-firewall-rule-${random_integer.sqldb_id.result}"
  server_id           = azurerm_mssql_server.example.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mssql_database" "test" {
  name           = "acctest-db-d-${random_integer.sqldb_id.result}"
  server_id      = azurerm_mssql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  #license_type   = "LicenseIncluded"
  max_size_gb    = 50
  #read_scale     = true
  sku_name       = "GP_Gen5_2"
  zone_redundant = true

  tags = {
   
  }

}


