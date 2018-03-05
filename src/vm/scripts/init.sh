#!/usr/bin/env bash

# install Apache web server
sudo apt install -y apache2

# Create web asset
sudo sh -c 'echo "Served with the help of Terraform" > /var/www/html/index.html'