# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}-${var.env}"
  location = var.location

  tags = {
    "Environment" = var.env
  }
}