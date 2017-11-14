#! /bin/sh -v
apt-get update
apt-get install apache2 -y
service apache2 start

echo "auto eth1
iface eth1 inet dhcp" >> /etc/network/interfaces
ifup eth1

