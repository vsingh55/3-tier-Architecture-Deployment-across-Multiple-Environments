terraform {
  required_providers {
    azuread = "~> 2.52.0"
    random  = "~> 3.1"
    azurerm = "~> 3.110.0"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "backendsa4tfvijaysingh"
    container_name       = "tfstate"
    key                  = "DeployTrio.terraform.tfstate"
  }
}


# data "azurerm_client_config" "example" {}

module "resourcegroup" {
  source   = "./modules/resourcegroup"
  project  = var.project
  env      = var.env
  location = var.location
}

module "ServicePrincipal" {
  source          = "./modules/ServicePrincipal"
  project         = var.project
  env             = var.env
  spn             = var.spn
  subscription_id = var.subscription_id

  depends_on = [
    module.resourcegroup
  ]
}


module "keyvault" {
  source              = "./modules/keyvault"
  project             = var.project
  env                 = var.env
  location            = var.location
  rg_name             = module.resourcegroup.rg_name
  spn_name            = module.ServicePrincipal.spn_name
  client_id           = module.ServicePrincipal.client_id
  client_secret       = module.ServicePrincipal.client_secret
  ssh_public_key_name = var.ssh_public_key_name
  ssh_public_key_path = var.ssh_public_key_path
  ssh_private_key_name = var.ssh_private_key_name
  ssh_private_key_path = var.ssh_private_key_path


  depends_on = [
    module.ServicePrincipal, module.resourcegroup
  ]
}

# Store client_id and Client_secret in Key_vault
resource "azurerm_key_vault_secret" "spn_secret" {
  name         = module.ServicePrincipal.client_id
  value        = module.ServicePrincipal.client_secret
  key_vault_id = module.keyvault.kv_id

  depends_on = [
    module.keyvault, 
  ]
}

module "network" {
  source        = "./modules/network"
  project       = var.project
  env           = var.env
  location      = var.location
  rg_name       = module.resourcegroup.rg_name
  vnet_cidr     = var.vnet_cidr
  subnet_cidr   = var.subnet_cidr
  inbound_rules = var.inbound_rules

  depends_on = [ module.resourcegroup,
  ]
}

module "bastion" {
  source = "./modules/bastion"
  project = var.project
  env = var.env
  location = var.location
  rg_name = module.resourcegroup.rg_name
  vnet_name = module.network.vnet_name

  depends_on = [ module.network ]
}

module "compute" {
  source         = "./modules/compute"
  env            = var.env
  location       = var.location
  rg_name        = module.resourcegroup.rg_name
  subnet_id      = module.network.snet_id
  ssh_public_key = module.keyvault.ssh_public_key
  

  # Constructing dynamic names
  nic_map = { for k, v in var.nic_map :
    k => {
      nic_name       = "${v.base_nic_name}-${var.purpose}-${var.project}-${var.env}"
      ip_config_name = "${v.base_ip_config_name}-${var.purpose}-${var.project}-${var.env}"
    }
  }

  vm_map = { for k, v in var.vm_map :
    k => {
      vm_name            = "${v.base_vm_name}-${var.purpose}-${var.project}-${var.env}"
      ip_name            = "${v.base_ip_name}-${var.purpose}-${var.project}-${var.env}"
      vm_size            = v.vm_size
      os_disk            = "${v.base_os_disk_name}-${var.purpose}-${var.project}-${var.env}"
      admin_ssh_key_user = v.admin_ssh_key_user
      custom_data_script = v.custom_data_script
    }
  }

  depends_on = [ module.resourcegroup, module.network, module.keyvault ]
}
