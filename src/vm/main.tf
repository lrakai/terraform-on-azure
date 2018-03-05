# locals are values that can be reused in a module 
locals {
  # Define shared tags for all resources
  shared_tags = {
    Note = "Created by vm module"
  }
}

# Public IP to reach the VM from the internet
resource "azurerm_public_ip" "web_public_ip" {
  name                         = "web_public_ip"
  location                     = "${var.resource_group_location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "static"

  tags = "${local.shared_tags}"
}

# Network interface to attach the VM to the network
resource "azurerm_network_interface" "web_interface" {
  name                      = "web_ni"
  location                  = "${var.resource_group_location}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${var.network_security_group_id}"

  ip_configuration {
    name                          = "web_ip_configuration"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.web_public_ip.id}"
  }

  tags = "${local.shared_tags}"
}

# Managed disk to store the OS disk of the VM
resource "azurerm_managed_disk" "web_disk" {
  name                 = "datadisk_existing"
  location             = "${var.resource_group_location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "40"

  tags = "${local.shared_tags}"
}

# VM to run the web server
resource "azurerm_virtual_machine" "web_server" {
  name                  = "web_server"
  location              = "${var.resource_group_location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.web_interface.id}"]
  vm_size               = "Basic_A1"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "web_os_disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "web_server"
    admin_username = "student"
    admin_password = "1Cloud_Academy_Labs!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/init.sh"
  }

  tags = "${merge(
      local.shared_tags,
      map(
        "Environment", var.environment
      )
  )}"
}