#! /bin/sh -v
echo "auto eth1
iface eth1 inet dhcp" >> /etc/network/interfaces
ifup eth1

