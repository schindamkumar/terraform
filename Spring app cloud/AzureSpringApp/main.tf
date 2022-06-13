provider "azurerm" {
features {}
}

module "springapp" {
source = "git::https://github.com/coolraku/terraform//AzureSpringAppsModule"

#name = var.sp_name
resource_group_name = var.rg_name

}
