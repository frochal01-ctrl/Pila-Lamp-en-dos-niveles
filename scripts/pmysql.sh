#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

ip route replace default via 10.0.2.2

apt-get update -y
apt-get install -y mariadb-server git

sed -i 's/^bind-address.*/bind-address = 192.168.56.20/' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

mysql -e "CREATE DATABASE IF NOT EXISTS lamp_db;"
mysql -e "CREATE USER IF NOT EXISTS 'lamp_user'@'192.168.56.10' IDENTIFIED BY 'password_seguro';"
mysql -e "GRANT ALL PRIVILEGES ON lamp_db.* TO 'lamp_user'@'192.168.56.10';"
mysql -e "FLUSH PRIVILEGES;"

cd /tmp
rm -rf iaw-practica-lamp
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
if [ -f /tmp/iaw-practica-lamp/db/database.sql ]; then
    mysql lamp_db < /tmp/iaw-practica-lamp/db/database.sql
fi

ip route del default || true









