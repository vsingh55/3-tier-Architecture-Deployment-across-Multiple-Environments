variable "project" {}
variable "env" {}
variable "rg_name" {}
variable "location" {}

variable "vnet_cidr" {
  description = "define vnet cidr"
  type        = list(string)
}
variable "subnet_cidr" {
  description = "define subnet cidr range"
  type        = list(string)
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
  default = [{
    name                       = "allow-ssh"
    priority                   = 100
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    protocol                   = "Tcp"
    },
    {
      name                       = "allow-http"
      priority                   = 110
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_range     = "80"
      protocol                   = "Tcp"
    },
    {
      name                       = "allow-https"
      priority                   = 120
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_range     = "443"
      protocol                   = "Tcp"
    },
    {
      name                       = "allow-SMTP"
      priority                   = 150
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_range     = "25"
      protocol                   = "Tcp"
    },
    {
      name                       = "allow-SMTPS"
      priority                   = 160
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_range     = "465"
      protocol                   = "Tcp"
    },
    {
      name                       = "allow-CustomTCP1"
      priority                   = 200
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_range     = "3000-10000"
      protocol                   = "Tcp"
      }, {
      name                       = "allow-CustomTCP2"
      priority                   = 210
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      destination_port_range     = "27017"
      protocol                   = "Tcp"
    }
  ]
}