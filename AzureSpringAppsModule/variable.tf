# Input Variables
#1. Resource Group Name
variable "resource_group_name" {
    description = "Resource group name"
    default = "testrg100"
    type = string
}

#2. Application Insights Name
variable "app_insights_name" {
    description = "Application Insights name"
    default = "appinsight"
    type = string
}

#3. Spring Cloud Name
variable "sc_service_name" {
    description = "Spring Cloud Service Name"
    default = "azurespringapp"
    type = string
}

#4. Spring Cloud SKU
variable "sc_service_sku" {
    description = "Spring Cloud SKU"
    default = "S0"
    type = string
}

#5. Resource Group Location
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
}

#6. Diags setting Name
variable "diag_set_name" {
  description = "Diags setting Name"
  type = string
  default = "diagnosticmonitor"
}

#7. Storage Account Name
variable "stg_mont_name" {
  description = "Storage Account Name"
  type = string
  default = "storagemonitorlog100"
}

#8. Storage Account Tier Name
variable "stg_tier_name" {
  description = "Storage Account Tier Name"
  type = string
  default = "Standard"
}

#9. Storage Account Replication Type
variable "stg_rpln_type" {
  description = "Storage Account Replication Type"
  type = string
  default = "ZRS"
}

#10. Virtual Netwrok Name
variable "spc_vnt_name" {
  description = "Virtual Netwrok Name"
  type = string
  default = "spc-vnet"
}

#11. Virtual Netwrok Address Space
variable "spc_vnt_addr" {
  description = "Virtual Netwrok Address Space"
  type = list(string)
  default = ["10.0.0.0/16"]
}

#12. Service Runtime Subnet
variable "spc_sr_subnet_name" {
  description = "Service Runtime Subnet Name"
  type = string
  default = "service-runtime-subnet"
}
#13. Service Runtime Subnet Address Prefix
variable "spc_sr_addr" {
  description = "Service Runtime Subnet Address Prefix"
  type = list(string)
  default = ["10.0.1.0/24"] 
}

#14. Spring App Subnet
variable "spc_sa_subnet_name" {
  description = "Spring App Subnet Name"
  type = string
  default = "spring-apps-subnet"
}
#15. Spring App Subnet Address Prefix
variable "spc_sa_addr" {
  description = "Spring App Subnet Address Prefix"
  type = list(string)
  default = ["10.0.2.0/24"]  
}


