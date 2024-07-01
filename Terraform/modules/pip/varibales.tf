variable "project" {
  type = string
}
variable "env" {
  type = string
}
variable "location" {
  type        = string
}
variable "vm_name" {
  type = string
}
variable "rg_name" {
  type = string
}
variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub" // update this path if your key is located elsewhere
}