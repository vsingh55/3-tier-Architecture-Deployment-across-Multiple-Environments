terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "storagefortfstatebkend"  //storagefortfstatebackend for VM
    container_name       = "tfstate"
    key                  = "DevlopTrio.local.terraform.tfstate"
  }
}
