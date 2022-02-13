terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  cloud {
    organization = "k-nikola"

    workspaces {
      name = "terraform-azure"
    }
  }
}
