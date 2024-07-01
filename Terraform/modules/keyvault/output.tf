output "kv_id" {
  value = azurerm_key_vault.kv.id
}

output "kv_name" {
  value = azurerm_key_vault.kv.name
}


output "ssh_public_key" {
  value = azurerm_key_vault_secret.ssh_public_key.value
}

