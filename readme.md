# heat-templates
The heat-templates repository contains various examples of heat templates that will work with the CloudVPS OpenStack cloud.

All heat templates here are **examples**, and must be treated as such. 
There will be **default values defined** in order to make all templates work out-of-the box, that are **not usable for production** purposes without customisation.

## separate_examples
**Default_networking.yml**: Create a basic internal network, router and a allow-all securitygroup.

---
**webservers.yml**: Add servers to existing network and install apache2

---
**LBaaS.yml**: Create a LBaaS Loadbalancer for existing servers in a internal network.  

*WIP: Needs to have ports attached to the LB for the security group to work*

*WIP: %index% does not work, use LBaaS_2servers.yml instead.*

---
**LBaaS_2servers.yml**: Create a LBaaS Loadbalancer for existing servers in a internal network.

*WIP: Needs to have ports attached to the LB for the security group to work*

---
**VRRP_2servers.yml**: Create 2 instances with a additional port for VRRP in a existing internal network.

Use as: ```openstack stack create -t VRRP_2instances.yml stackname```


## LBaaS_with_env_file
Examples to create LBaaS with a environment file.

Use as;

```openstack stack create -t LBaaS.yml -e LBaaS_env.yml  stackname```

LBaaS_resource.yaml is included by the environment file.

## keepalived_example
Examples to create a keepalived cluster with LBaaS or two or more keepalived servers in front of 4 or more appservers.

Use as:

```openstack stack create -t 01_create_cluster.yml -e 00_params.yaml -e 00_registry.yaml stackname```


## cluster_example
More detailed examples to create a keepalived cluster with LBaaS or two or more keepalived servers in front of 4 or more appservers.

Also includes internal dbservers with a keepalived ip and installs wordpress.
This is for demo, getting started or P.O.C. purposes only. Failover does work however (sql) replication is not set up.


When using horizon use by opening 
 - 01_master_github.yml
 - 00_registry_github.yaml

You could also link to the raw github files without downloading.


When using the OpenStack client (see our (https://www.cloudvps.nl/openstack/openstack-getting-started-command-line) "getting started guide") ):
 - Edit the 01_master.yml to include your ssh key name.
 - And use as:

```openstack stack create -t 01_master.yml -e 00_registry_local.yaml stackname```



