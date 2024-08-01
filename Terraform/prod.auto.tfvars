env             = "prod"
location        = "centralindia"
spn             = "SPN"
subscription_id = "adc11db4-778a-419e-958f-479833cfb23f" // Replace with your actual subscription ID

vnet_cidr   = ["10.0.0.0/16"]
subnet_cidr = ["10.0.1.0/24"]

ssh_public_key_name = "sshkey-pub-prod"
ssh_public_key_path = "~/.ssh/id_rsa.pub"

ssh_private_key_name = "sshkey-pvt-prod"
ssh_private_key_path = "~/.ssh/id_rsa"

aks_location = "australiaeast"


# Define NIC configurations following Azure naming conventions
nic_map = {
  "jenkins" = {
    base_nic_name        = "nic"
    base_ip_config_name  = "ip-nic"
    base_pip_name        = "pip"
  },
  "sonarqube" = {
    base_nic_name        = "nic"
    base_ip_config_name  = "ip-nic"
    base_pip_name        = "pip"
  }
}


# Define VM configurations following Azure naming conventions
vm_map = {
  "jenkins" = {
    base_vm_name         = "vm"
    base_ip_name         = "ip"
    vm_size              = "Standard_B2s"
    base_os_disk_name    = "os_disk-jenkins"
    admin_ssh_key_user   = "adminuser"
    custom_data_script   = "../scripts/jenkinsProd.sh"
  },
  "sonarqube" = {
    base_vm_name         = "vm"
    base_ip_name         = "ip"
    vm_size              = "Standard_B2s"
    base_os_disk_name    = "os_disk-sonarqube"
    admin_ssh_key_user   = "adminuser"
    custom_data_script   = "../scripts/sonarqube.sh"
  }
}


# NSG inbound rules
inbound_rules = [
  {
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
  },
  {
    name                       = "allow-CustomTCP2"
    priority                   = 210
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    destination_port_range     = "27017"
    protocol                   = "Tcp"
  }
]
