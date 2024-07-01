data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = "kv-${var.project}-${var.env}"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  enable_rbac_authorization   = false
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]

    certificate_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]
  }
}

# Store sshkey-pub and sshkey-pvt in Key_vault to access Compute resources using bastion
resource "azurerm_key_vault_secret" "ssh_public_key" {
  name         = var.ssh_public_key_name
  value        = file(var.ssh_public_key_path)
  key_vault_id = azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "ssh_private_key" {
  name         = var.ssh_private_key_name
  value        = file(var.ssh_private_key_path)
  key_vault_id = azurerm_key_vault.kv.id
}

# Store client_id and Client_secret in Key_vault
resource "azurerm_key_vault_secret" "spn_client_id" {
  name         = "${var.spn_name}-client-id"
  value        = var.client_id
  key_vault_id = azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "spn_client_secret" {
  name         = "${var.spn_name}-client-secret"
  value        = var.client_secret
  key_vault_id = azurerm_key_vault.kv.id
}

