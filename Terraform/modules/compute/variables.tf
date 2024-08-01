variable "rg_name" {}
variable "location" {}
variable "env" {}
variable "subnet_id" {
  description = "The ID of the subnet in which to create the network interfaces"
  type        = string
}
variable "ssh_public_key" {
  description = "The SSH public key retrieved from Azure Key Vault"
  type        = string
}

# Define the variables for NIC 
variable "nic_map" {
  description = "A map of VM's configurations for each vm"
  type = map(object({
    nic_name              = string
    ip_config_name = string
    pip_name       = string
  }))
  
}
# Define the variables for Virtual Machines 
variable "vm_map" {
  description = "A map of VM's configurations"
  type = map(object({
    vm_name                = string
    ip_name                = string
    vm_size                = string
    os_disk                = string
    admin_ssh_key_user = string
    custom_data_script = string
  }))
  
}
