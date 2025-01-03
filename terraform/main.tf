terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "key_vault_ci_cd_sample" {
  name     = "key-vault-ci-cd-sample-rg"
  location = "UK South"
}