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
resource "azurerm_storage_account" "aci-sa" {
  name                = "acistorageacct"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  account_tier        = "Standard"

  account_replication_type = "LRS"
  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_share" "aci-share" {
  name                 = "aci-test-share"
  storage_account_name = azurerm_storage_account.aci-sa.name
  quota                = 50

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
    environment_variables = {
      db_uri     = var.DB_URI
      secret_key = var.SECRET_KEY
    }
  }
  container {
    name   = var.db_container_name
    image  = "mysql:5.7"
    cpu    = "0.5"
    memory = "0.5"
    environment_variables = {
      MYSQL_ROOT_PASSWORD = var.MYSQL_ROOT_PASSWORD
      MYSQL_DATABASE      = "flask_nikola"
    }
    volume {
      name                 = "data"
      share_name           = azurerm_storage_share.aci-share.name
      storage_account_name = azurerm_storage_account.aci-sa.name
      storage_account_key  = azurerm_storage_account.aci-sa.primary_access_key
      read_only            = false
      mount_path           = "/var/lib/mysql"
    }

  }
  tags = {
    environment = var.environment
  }
}
