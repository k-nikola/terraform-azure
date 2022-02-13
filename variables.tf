variable "resource_group" {
  default = "nikolaResourceGroup"
}
variable "azure_region" {
  default = "westeurope"
}
variable "environment" {
  default = "Dev"
}
variable "container_group" {
  default = "nikolaContainerGroup"
}
variable "container_name" {
  default = "nksite"
}
variable "db_container_name" {
  default = "nksite-db"
}
variable "DB_URI" {
  sensitive = true
}
variable "SECRET_KEY" {
  sensitive = true
}
variable "MYSQL_ROOT_PASSWORD" {
  sensitive = true
}
