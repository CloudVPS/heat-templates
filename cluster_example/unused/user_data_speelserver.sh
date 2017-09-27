#! /bin/sh -v
###### DIT NIET LIVE GEBRUIKEN DUHHH
echo -e "Cloudis0K\nCloudis0K" | passwd

apt-get update
apt-get install python-openstackclient python-glanceclient python-novaclient python-neutronclient python-swiftclient python-cinderclient python-ceilometerclient python-heatclient -y

echo "export OS_PASSWORD=
export OS_USERNAME=<User Name>
export OS_TENANT_NAME=<Project Name>
export OS_TENANT_ID=<Project ID>
export OS_AUTH_URL=https://identity.openstack.cloudvps.com/v3
" >> /root/osauth_example
