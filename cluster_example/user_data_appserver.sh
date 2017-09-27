#! /bin/sh -v
WP_DOMAIN="kinderboekenwebshop.nl"
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
sudo apt install -y nginx php php-mysql php-curl php-gd php-mcrypt mysql-client

sudo mkdir -p $WP_PATH/public $WP_PATH/logs
sudo tee /etc/nginx/sites-available/$WP_DOMAIN <<EOF
server {
  listen 80;
  server_name $WP_DOMAIN www.$WP_DOMAIN _;

  root $WP_PATH/public;
  index index.php;

  access_log $WP_PATH/logs/access.log;
  error_log $WP_PATH/logs/error.log;

  location / {
    try_files \$uri \$uri/ /index.php?\$args;
  }

  location ~ \.php\$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php7.0-fpm.sock;
  }
}
EOF
sudo ln -s /etc/nginx/sites-available/$WP_DOMAIN /etc/nginx/sites-enabled/$WP_DOMAIN
#sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx


### START The WP installation ###

sudo rm -rf $WP_PATH/public/ # !!!
sudo mkdir -p $WP_PATH/public/
sudo chown -R $USER $WP_PATH/public/
cd $WP_PATH/public/

wget https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz --strip-components=1
tar --strip-components=1 -zxvf latest.tar.gz -C $WP_PATH/public
rm latest.tar.gz

mv wp-config-sample.php wp-config.php
sed -i s/database_name_here/$WP_DB_NAME/ wp-config.php
sed -i s/username_here/$WP_DB_USERNAME/ wp-config.php
sed -i s/password_here/$WP_DB_PASSWORD/ wp-config.php
sed -i s/localhost/$WP_DB_HOST/ wp-config.php
echo "define('FS_METHOD', 'direct');" >> wp-config.php

sudo chown -R www-data:www-data $WP_PATH/public/

echo "waiting for databases"
while ! mysql -u $WP_DB_USERNAME -p$WP_DB_PASSWORD -h $WP_DB_HOST -e \"show databases\" | grep $WP_DB_NAME/ &>/dev/null; do echo "database failed - `date`"; done ; echo "database found - `date`" ;


curl "http://127.0.0.1/wp-admin/install.php?step=2" \
  --data-urlencode "weblog_title=$WP_DOMAIN"\
  --data-urlencode "user_name=$WP_ADMIN_USERNAME" \
  --data-urlencode "admin_email=$WP_ADMIN_EMAIL" \
  --data-urlencode "admin_password=$WP_ADMIN_PASSWORD" \
  --data-urlencode "admin_password2=$WP_ADMIN_PASSWORD" \
  --data-urlencode "pw_weak=1"
