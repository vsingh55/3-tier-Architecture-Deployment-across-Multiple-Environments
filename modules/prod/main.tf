# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_cidr
  depends_on          = [azurerm_resource_group.rg]
}

# Create subnet 
resource "azurerm_subnet" "subnet" {
  name                 = "public"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_cidr
  depends_on           = [azurerm_virtual_network.vnet]
}

# Create public IP resources
resource "azurerm_public_ip" "pip_vm" {
  for_each            = var.vm_map
  name                = each.value.ip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

# Obtaining public ip address
data "azurerm_public_ip" "pip_data" {
  for_each            = var.vm_map
  name                = azurerm_public_ip.pip_vm[each.key].name
  resource_group_name = azurerm_resource_group.rg.name
}

# Create network security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_resource_group.rg]
}

#Create network security group rules
resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = { for rule in var.inbound_rules : rule.name => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_resource_group.rg.name
  depends_on                  = [azurerm_network_security_group.nsg]
}

# Create association of NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# create network interface for each VM
resource "azurerm_network_interface" "nic" {
  for_each            = var.nic_map
  name                = each.value.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [azurerm_virtual_network.vnet, azurerm_subnet.subnet]
}

# Create linux virtual machine 
resource "azurerm_linux_virtual_machine" "vm" {
  for_each              = var.vm_map
  name                  = each.value.vm_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = each.value.vm_size
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic[each.key].id] // associate nic
  depends_on            = [azurerm_network_interface.nic]

  admin_ssh_key {
    username   = each.value.admin_ssh_key_username
    public_key = file("~/.ssh/azurekey.pub")
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
    env = "prod"
    UsedFor = "production"
  }
}













