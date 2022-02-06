provider "azurerm" {
  # Configuration options
  features {
  }
}
# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.azure_region

  tags = {
    environment = var.environment
  }
}
# Create a container group
resource "azurerm_container_group" "ncg" {
  name                = var.container_group
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "public"
  os_type             = "Linux"

  container {
    name   = var.container_name
    image  = "t0b9/tf-site"
    cpu    = "0.5"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
  tags = {
    environment = var.environment
  }
}
