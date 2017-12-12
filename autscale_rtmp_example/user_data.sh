#!/bin/bash
apt update
apt install build-essential libpcre3 libpcre3-dev libssl-dev unzip -y
wget http://nginx.org/download/nginx-1.13.1.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
tar -zxvf nginx-1.13.1.tar.gz
unzip master.zip

cd nginx-1.13.1
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
make install


rm /usr/local/nginx/html/index.html
wget -P /usr/local/nginx/html/ http://download.cloudvps.com/kerstcloud/style.css
wget -P /usr/local/nginx/html/ http://download.cloudvps.com/kerstcloud/index.html


echo "
worker_processes  10;
events {
    worker_connections  1024;
}

http {
    server {
        listen       80;
        server_name  localhost;

        location / {
            root   html;
            index  index.html index.htm;
        }

    }

#    server {
#        listen       443 ssl;
#        server_name  localhost;
#
#        ssl_certificate      cert.pem;
#        ssl_certificate_key  cert.key;
#
#        ssl_session_cache    shared:SSL:1m;
#        ssl_session_timeout  5m;
#
#        ssl_ciphers  HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers  on;
#
#        location / {
#            root   html;
#            index  index.html index.htm;
#        }
#    }

}

rtmp {
        server {
                listen 1935;
                chunk_size 4096;

                application live {
                        deny publish all;
                        allow play all;
                        pull rtmp://83.96.202.138:80/live/test name=cloudvpstree;
                        live on;
                        record off;
                        wait_key on;
                        interleave on;
                        publish_notify on;
                        sync 10ms;
                        wait_video on;
                }
        }
}" > /usr/local/nginx/conf/nginx.conf

/usr/local/nginx/sbin/nginx -s stop
/usr/local/nginx/sbin/nginx

