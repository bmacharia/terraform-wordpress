#!/bin/bash

# Install Updates
sudo yum update -y
sudo yum upgrade -y

sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo systemctl enable httpd


sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
sudo tar -zxvf latest.tar.gz
sudo cp -rvf wordpress/* .
sudo rm -R wordpress
sudo rm latest.tar.gz
sudo cp wp-config-sample.php wp-config.php

sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
sudo find /var/www -type f -exec sudo chmod 0664 {} \;


# Get RDS credentials from AWS Secrets Manager and store in variables
secret=$(aws secretsmanager get-secret-value --secret-id "cp/rds/password")
username=$(echo $secret | jq -r .SecretString | jq -r .username)
password=$(echo $secret | jq -r .SecretString | jq -r .password)
endpoint=$(terraform output rds_endpoint)

# Update the wp-config.php file  with the RDS endpoint and credentials
sudo sed -i "s/database_name_here/mydb/g" wp-config.php
sudo sed -i "s/username_here/$username/g" wp-config.php
sudo sed -i "s/password_here/$password/g" wp-config.php
sudo sed -i "s/localhost/$endpoint/g" wp-config.php


# Restart Apache Server
sudo systemctl restart httpd



