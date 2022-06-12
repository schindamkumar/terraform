#Provider Block
provider "azurerm" {
    features {} 
}

#Create Resource group 
resource "azurerm_resource_group" "sa_rg" {
    name      = var.resource_group_name
    location  = var.resoure_group_location
}