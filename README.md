# heat-template
1. vm_net_router.yaml
   Create a private network, router, and two instances named Server-01, Server-02.
   For Server-01:
   a.) Setup proxy
   b.) Install docker
   c.) Install python-dev, python-pip and python-heatclient. The purpose is to create a heat client environment.
   d.) Create openrc for Openstack environemnt setting. It will be used for heat client.
   e.) Install nsenter. The purpose is to enter container (docker) .
   f.) Install pipework for docker network utilization.
   After the package installation and setting, you can do the docker programming and testing. Besides, you can run heat template
   in the VM. 
