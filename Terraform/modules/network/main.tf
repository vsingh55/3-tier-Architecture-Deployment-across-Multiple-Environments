# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project}-${var.location}-${var.env}"  
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_cidr

}

# Create subnet 
resource "azurerm_subnet" "subnet" {
  name                 = "snet-compute-${var.project}-${var.location}-${var.env}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_cidr

}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.project}-${var.location}-${var.env}"
  location            = var.location
  resource_group_name = var.rg_name

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
  resource_group_name         = var.rg_name
  depends_on                  = [azurerm_network_security_group.nsg]
}

# Create association of NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}