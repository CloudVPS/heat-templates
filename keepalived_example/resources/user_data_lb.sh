#! /bin/sh -v
apt-get update
apt install keepalived haproxy rsyslog tcpdump -y
echo "global_defs {
   notification_email {
          cees@cloudvps.com
   }
   notification_email_from lb1@test
   smtp_server 194.60.207.37
   smtp_connect_timeout 30
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
    notify /usr/local/bin/keepalived-intern.sh

    authentication {
        auth_type PASS
        auth_pass f4cbe02aeec63002eaf3580
    }

    virtual_ipaddress {
        10.0.0.18/32
    }
}

" >> /etc/keepalived/keepalived.conf
