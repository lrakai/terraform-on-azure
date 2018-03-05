#!/usr/bin/env bash

# install Apache web server
sudo apt install -y apache2

# Create a web asset in the default serving directory
sudo sh -c 'echo "Served with the help of Terraform" > /var/www/html/index.html'