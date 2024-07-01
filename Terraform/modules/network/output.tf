output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
output "subnet_name" {
  value = azurerm_subnet.subnet.name
}
output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
output "snet_id" {
  value = azurerm_subnet.subnet.id
}
output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}
