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