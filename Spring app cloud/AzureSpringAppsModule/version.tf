# Terraform settings block
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.6.0"
    }
  }
}
