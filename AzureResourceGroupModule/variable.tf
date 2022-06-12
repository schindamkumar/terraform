# Input Variables
#1. Resource Group Name
variable "resource_group_name" {
    description = "Resource group name"
    default = "starbuckspips1"
    type = string
}

#2. Resource Group Location
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
}