output "client_id" {
  description = "The application id of AzureAD application created."
  value       = module.ServicePrincipal.client_id
}

output "client_secret" {
  description = "Password for service principal."
  value       = module.ServicePrincipal.client_secret
  sensitive   = true

}

output "resource_group_name" {
  value = module.resourcegroup.rg_name
}

output "K8s_config" {
    value = module.aks.kube_config_raw      
    sensitive = true
}

