terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        versiversion = "~> 2.0"
    }
    azuread = {
        source = "hashicorp/azuread"
        version = "~ 2.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"
    }
  }
}

backend "azurerm" {
    resource_group_name = "terraform-storage-rg"
    storage_account_name = "terraformsastate1"
    container_name = "tfstatefiles"
    key = "terraform-custom.tfstate"
}

provider "azurerm" {
  features {}
}

resource "random_pet" "aksrandom" { }