variable "project" {
  description = "The name of Porject/App/web"
  type        = string
}
variable "env" {
  description = "The environment (e.g.,local, dev, prod)"
  type        = string
}
variable "location" {
  description = "The location of the resource group"
  type        = string
}
variable "spn" {
  description = "It is prefix of spn_name(service principal name)"
  type        = string
}
variable "subscription_id" {
  description = "Subscription id of your Azure account"
  type        = string
}

variable "ssh_public_key_name" {
  description = "Name for the SSH public key secret"
  type        = string
}
variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}
variable "ssh_private_key_name" {
  description = "Name for the SSH private key secret"
  type        = string
}
variable "ssh_private_key_path" {
  description = "Path to the SSH private key file"
  type        = string
}
variable "vnet_cidr" {
  description = "define vnet cidr"
  type        = list(string)
}
variable "subnet_cidr" {
  description = "define subnet cidr range"
  type        = list(string)
}
variable "purpose" {
  description = "Purpose of compute instance"
  type = string
}

variable "inbound_rules" {
  description = "List of inbound rules for NSG"
  type = list(object({
    name                       = string
    priority                   = number
    source_address_prefix      = string
    destination_address_prefix = string
    destination_port_range     = string
    protocol                   = string
  }))

}
# Define the variables for NIC 
variable "nic_map" {
  description = "A map of VM's configurations for each vm"
  type = map(object({
    base_nic_name       = string
    base_ip_config_name = string
  }))
  
}

# Define the variables for Virtual Machines 
variable "vm_map" {
  description = "A map of VM's configurations"
  type = map(object({
    base_vm_name            = string
    base_ip_name            = string
    vm_size            = string
    base_os_disk_name          = string
    admin_ssh_key_user = string
    custom_data_script = string
  }))
  
}






