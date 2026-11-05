#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y apache2 php libapache2-mod-php php-mysql git

rm -rf /var/www/html/*
cd /tmp
rm -rf iaw-practica-lamp
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
cp -r /tmp/iaw-practica-lamp/src/* /var/www/html/

sed -i "s/define('DB_HOST', '.*');/define('DB_HOST', '192.168.56.20');/" /var/www/html/config.php
sed -i "s/define('DB_NAME', '.*');/define('DB_NAME', 'lamp_db');/" /var/www/html/config.php
sed -i "s/define('DB_USER', '.*');/define('DB_USER', 'lamp_user');/" /var/www/html/config.php
sed -i "s/define('DB_PASSWORD', '.*');/define('DB_PASSWORD', 'password_seguro');/" /var/www/html/config.php

chown -R www-data:www-data /var/www/html/
systemctl restart apache2






