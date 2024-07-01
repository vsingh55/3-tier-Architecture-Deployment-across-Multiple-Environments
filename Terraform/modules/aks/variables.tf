variable "project" {
  description = "The name of Porject/App/web"
  type        = string
}
variable "env" {
  description = "The environment (e.g.,local, dev, prod)"
  type        = string
}

# variable "spn" {
#   description = "It is prefix of spn_name(service principal name)"
#   type        = string
# }
variable "aks_location" {
  type = string
}
variable "rg_name" {
  type = string
}

variable "service_principal_name" {
  type = string
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub" // Ensure this file exists or update with your SSH public key path
}

variable "client_id" {}

variable "client_secret" {
  type      = string
  sensitive = true
}