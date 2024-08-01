# create network interface for each VM
resource "azurerm_network_interface" "nic" {
  for_each            = var.nic_map
  name                = each.value.nic_name
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = each.value.ip_config_name              
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}

# Create public IP for each VM
resource "azurerm_public_ip" "pip" {
  for_each            = var.nic_map
  name                = each.value.pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

# Create linux virtual machine 
resource "azurerm_linux_virtual_machine" "vm" {
  for_each              = var.vm_map
  name                  = each.value.vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  size                  = each.value.vm_size
  admin_username        = "adminuser"
  user_data             = base64encode(file(each.value.custom_data_script))
  network_interface_ids = [azurerm_network_interface.nic[each.key].id] // associate nic

  
  depends_on            = [azurerm_network_interface.nic]

  admin_ssh_key {
    username   = each.value.admin_ssh_key_user
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = each.value.os_disk
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    "env"     = var.env
  }
}