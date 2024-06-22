# all the variables to use in this project
variable "project_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "network_security_group" {
  type = string
}

variable "virtual_network_name" {
  type = string
}
variable "vnet_cidr" {
  description = "define vnet cidr"
  type        = list(string)
}
variable "subnet_cidr" {
  description = "define subnet cidr range"
  type        = list(string)
}

# Define the variables for NIC 
variable "nic_map" {
  description = "A map of VM's configurations for each vm"
  type = map(object({
    nic_name              = string
    ip_configuration_name = string
  }))
  default = {
    "vm1" = {
      nic_name              = "local-nic"
      ip_configuration_name = "local-internal"
    }
  }
}
# Define the variables for Virtual Machines 
variable "vm_map" {
  description = "A map of VM's configurations"
  type = map(object({
    vm_name                = string
    ip_name                = string
    vm_size                = string
    os_disk                = string
    admin_ssh_key_username = string
  }))
  default = {
    "vm1" = {
      vm_name                = "local-VM"
      ip_name                = "local-VM-pip"
      vm_size                = "Standard_B2s"
      os_disk                = "local-os-disk"
      admin_ssh_key_username = "adminuser"
    }
  }
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

# Create environment variables
# Cloudinary: For storing images in the database.

# Mapbox Token: For linking campground locations on the map.
variable "CLOUDINARY_CLOUD_NAME" {
  description = "Its the value provided by cloudinary."   
  type = string
}

variable "CLOUDINARY_KEY" {
  description = "cloudinary variable"
  type = string
}
variable "CLOUDINARY_SECRET" {
  type = string
}
variable "MAPBOX_TOKEN" {
  type = string
}
variable "DB_URL" {
  description = "It can be get from cloud provider as you setup your account. I am using MongoDB Atlas. "
  type = string
}
variable "SECRET" {
  description = "anything you want"
  type = string
}