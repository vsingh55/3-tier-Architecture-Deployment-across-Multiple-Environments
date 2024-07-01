resource "azurerm_ssh_public_key" "pip_vm" {
  name                = "pip-${var.project}-${var.env}-${var.location}-${var.vm_name}"
  resource_group_name = var.rg_name
  location            = var.location
  public_key          = file(var.ssh_public_key_path)
}
