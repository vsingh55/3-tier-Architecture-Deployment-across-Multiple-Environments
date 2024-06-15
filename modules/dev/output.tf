output "public_ip_address" {
  value = {
    for vm_key, vm_value in azurerm_linux_virtual_machine.vm :
    vm_value.name => data.azurerm_public_ip.pip_data[vm_key].ip_address
  }
}