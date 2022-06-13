provider "azurerm" {
features {}
}

module "mssqldb" {
source = "git::https://github.com/coolraku/terraform//SQLDB/AzureSQLDBModule"

#name = var.sp_name
resource_group_name = var.rg_name

}
