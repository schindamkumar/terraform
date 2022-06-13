##Input Variables
#1.Resource Group Name
variable "resource_group_name" {
    description = "Resource Group Name"
    default = "sql-rg111"
}

#2.Resource Group Location
variable "resource_group_location" {
    description = "Resource Group Location"
    default = "eastus"
}

#3.Storage Account Type
variable "storage_account_type" {
    description = "Storage Account Type"
    default = "Standard"
}

#4.Storage Account Replication type
variable "storage_account_replication_type" {
    description = "Storage Account Replication type"
    default = "ZRS"
}

#5.Storage Account Kind
variable "storage_account_kind" {
    description = "Storage Account Kind"
    default = "StorageV2"
}

#5.Storage Account Subscription id
variable "storage_account_sub_id" {
    description = "Storage Account Subscription id"
    default = "75e37e8a-d263-4fad-8ccf-515bc3110e7f"
    sensitive = true
}

#6.SQL Server Administrator Login
variable "sql_ser_ad_login" {
    description = "SQL Server Administrator Login"
    type = string
    default = "sqladmin100"
    sensitive = true
}

#7.SQL Server Administrator Password
variable "sql_ser_ad_pwd" {
    description = "SQL Server Administrator Password"
    type = string
    default = "sqladmin@100"
    sensitive = true
}