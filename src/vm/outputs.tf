output "web_server_public_ip" {
  value = "${azurerm_public_ip.web_public_ip.ip_address}"
}