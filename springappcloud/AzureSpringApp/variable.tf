# Input Variables
#1. Resource Group Name
variable "rg_name" {
    description = "Resource group name"
    default = "testrg100"
    type = string
}

#2. springapp Name
variable "sp_name" {
    description = "Azure Spring Apps Name"
    default = "azurespringapp"
    type = string
}