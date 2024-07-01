# Create subnet for bastion
resource "azurerm_subnet" "bas_snet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.3.0/26"]
}

resource "azurerm_public_ip" "bas_pip" {
  name                = "pip-bas-${var.project}-${var.location}-${var.env}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bas_host" {
  name                 = "bastion-host-${var.project}-${var.location}-${var.env}" 
  location             = var.location
  resource_group_name  = var.rg_name
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bas_snet.id
    public_ip_address_id = azurerm_public_ip.bas_pip.id
  }
}
