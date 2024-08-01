# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.aks_location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                = "AKS-cluster-${var.project}-${var.aks_location}-${var.env}"
  location            = var.aks_location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.rg_name}-cluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.rg_name}-nrg"

  default_node_pool {
    name                = "defaultpool"
    vm_size             = "Standard_D2as_v4" //Standard_B2s, Standard_B1s for free services
    zones               = [1, 2, 3]
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = var.env
      "nodepoolos"    = "linux"
    }
    tags = {
      "nodepool-type" = "system"
      "environment"   = var.env
      "nodepoolos"    = "linux"
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  linux_profile {
    admin_username = "aminuser"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}


