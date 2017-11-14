#! /bin/sh -v
WP_DOMAIN="f1shop.demo.cloudvps.com"
WP_ADMIN_USERNAME="admin"
WP_ADMIN_PASSWORD="admin"
WP_ADMIN_EMAIL="no@spam.org"
WP_DB_NAME="wordpress"
WP_DB_USERNAME="wordpress"
WP_DB_PASSWORD="wordpress"
WP_DB_HOST="10.0.0.11"
WP_PATH="/var/www/wordpress"
MYSQL_ROOT_PASSWORD="root"

apt-get update
echo "mysql-server-5.7 mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
sudo apt install -y mysql-server keepalived -y

sed -i s/127.0.0.1/0.0.0.0/ /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

mysql -u root -p$MYSQL_ROOT_PASSWORD <<EOF
CREATE USER '$WP_DB_USERNAME'@'%' IDENTIFIED BY '$WP_DB_PASSWORD';
CREATE DATABASE $WP_DB_NAME;
GRANT ALL ON $WP_DB_NAME.* TO '$WP_DB_USERNAME'@'%';
EOF

echo "global_defs {
   router_id lb1
}

vrrp_sync_group VG_1 {
     group {
        INTERN
     }
}

}

vrrp_instance INTERN {
    interface eth0
    virtual_router_id 99
    state EQUAL
    advert_int 1
    smtp_alert

    authentication {
        auth_type PASS
        auth_pass f4cbe02aeec63002eaf3580
    }

    virtual_ipaddress {
        10.0.0.254/32
    }
}

" >> /etc/keepalived/keepalived.conf

sudo systemctl restart keepalived

