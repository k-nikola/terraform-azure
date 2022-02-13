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
    image  = "t0b9/flask-app-nikola"
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 5000
      protocol = "TCP"
    }
    secure_environment_variables = {
      db_uri     = var.DB_URI
      secret_key = var.SECRET_KEY
    }
  }
  container {
    name   = var.db_container_name
    image  = "mysql:5.7"
    cpu    = "0.5"
    memory = "0.5"
    secure_environment_variables = {
      MYSQL_ROOT_PASSWORD = var.MYSQL_ROOT_PASSWORD
      MYSQL_DATABASE      = "flask_nikola"
    }

  }
  tags = {
    environment = var.environment
  }
}
