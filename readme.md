# heat-templates
The heat-templates repository contains various examples of heat templates that will work with the CloudVPS OpenStack cloud.

All heat templates here are examples, and must be treated as such. 
There will be default values defined in order to make all templates work out-of-the box, that are not usable for production purposes.

## separate_examples
webservers.yml: Add servers to existing network and install apache2

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

Use as: 

```openstack stack create -t 01_master.yml -e 00_registry.yaml stackname```

