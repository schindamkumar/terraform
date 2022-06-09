#Provider Block
provider "azurerm" {
    features {} 
}

#Create Resource group 
resource "azurerm_resource_group" "sa_rg" {
    name      = var.resource_group_name
    location  = var.resoure_group_location
}

#Create Storage Account for Diagnostic monitor logs
resource "azurerm_storage_account" "monitorlog" {
  name = var.stg_mont_name
  resource_group_name = azurerm_resource_group.sa_rg.name
  location = azurerm_resource_group.sa_rg.location
  account_tier = var.stg_tier_name
  account_replication_type = var.stg_rpln_type
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.spc_vnt_name
  location            = azurerm_resource_group.sa_rg.location
  resource_group_name = azurerm_resource_group.sa_rg.name
  address_space       = var.spc_vnt_addr
}

resource "azurerm_subnet" "service-runtime-subnet" {
  name                 = var.spc_sr_subnet_name
  resource_group_name  = azurerm_resource_group.sa_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.spc_sr_addr
}

resource "azurerm_subnet" "spring-apps-subnet" {
  name                 = var.spc_sa_subnet_name
  resource_group_name  = azurerm_resource_group.sa_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.spc_sa_addr 
}

#Create Application Insights
resource "azurerm_application_insights" "sc_app_insights" {
  name                = var.app_insights_name
  location            = azurerm_resource_group.sa_rg.location
  resource_group_name = azurerm_resource_group.sa_rg.name
  application_type    = "web"
  depends_on = [azurerm_resource_group.sa_rg]
}

#Create Spring Cloud Service
resource "azurerm_spring_cloud_service" "sc" {
  name                = var.sc_service_name 
  resource_group_name = azurerm_resource_group.sa_rg.name
  location            = azurerm_resource_group.sa_rg.location
  sku_name            = var.sc_service_sku
  /*
  network {
    app_subnet_id                   = azurerm_subnet.spring-apps-subnet.id
    service_runtime_subnet_id       = azurerm_subnet.service-runtime-subnet.id
    cidr_ranges                     = ["10.1.0.0/16","10.2.0.0/16","10.3.0.0/16"]
  }*/
  
  timeouts {
      create = "60m"
      delete = "2h"
  }

  depends_on = [azurerm_resource_group.sa_rg]
  
}

#Update Diags setting for Spring Cloud Service

resource "azurerm_monitor_diagnostic_setting" "sc_diag" {
  name                        = var.diag_set_name
  target_resource_id          = azurerm_spring_cloud_service.sc.id
  storage_account_id          = azurerm_storage_account.monitorlog.id

  log {
    category = "ApplicationConsole"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}