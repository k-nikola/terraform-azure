output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}
output "public_ip" {
  value = azurerm_container_group.ncg.public_ip
}
