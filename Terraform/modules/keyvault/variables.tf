variable "project" {
  type = string
}
variable "env" {
  type = string
}
variable "rg_name" {
  type = string
}
variable "location" {
  type = string
}
variable "spn_name" {
  type = string
}
variable "client_id" {
  description = "Client ID of the Service Principal"
  type        = string
}
variable "client_secret" {
  description = "Client Secret of the Service Principal"
  type        = string
}

variable "ssh_private_key_name" {
  description = "Name for the SSH private key secret"
  type        = string
}
variable "ssh_public_key_name" {
  description = "Name for the SSH public key secret"
  type        = string
}
variable "ssh_private_key_path" {
  description = "Path to the SSH private key file"
  type        = string
}
variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}


