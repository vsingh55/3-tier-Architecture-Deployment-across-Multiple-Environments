# all the variables to use in this project
variable "project_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "azurerm_network_security_group" {
  type        = string
}
variable "azurerm_virtual_network" {
  type = string
}
