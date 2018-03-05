#!/usr/bin/env bash

# install Apache web server
sudo apt install apache2

# Create web asset
echo "Served with the help of Terraform" > /var/www/html/index.html