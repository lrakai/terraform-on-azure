provider "azurerm" {
  version = "< 2"
}

data "azurerm_resource_group" "dev" {
  name = "terraform-lab"
}

module "network" {
  source              = "Azure/network/azurerm"
  version             = "2.0.0"
  resource_group_name = "${data.azurerm_resource_group.dev.name}"
  location            = "${data.azurerm_resource_group.dev.location}"
  subnet_names        = ["subnet1"]
  vnet_name           = "web"

  tags = {
    environment = "dev"
  }
}

module "security" {
    source              = "Azure/network-security-group/azurerm//modules/HTTP"
    resource_group_name = "${data.azurerm_resource_group.dev.name}"
    location            = "${data.azurerm_resource_group.dev.location}"
    security_group_name = "nsg"
    
    custom_rules = [
      {
        name                   = "ssh"
        priority               = "200"
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "tcp"
        destination_port_range = "22"
        description            = "ssh-access"
      },
    ]

    tags = {
      environment = "dev"
    }
}

module "vm" {
  source = "./vm"

  resource_group_name       = "${data.azurerm_resource_group.dev.name}"
  resource_group_location   = "${data.azurerm_resource_group.dev.location}"
  subnet_id                 = "${module.network.vnet_subnets[0]}"
  network_security_group_id = "${module.security.network_security_group_id}"
}