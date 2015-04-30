# heat-template
**A. vm_net_router.yaml**  
Create a private network, router, and two instances named Server-01, Server-02.  
For Server-01:  
1. Setup proxy  
2. Install docker  
3. Install python-dev, python-pip and python-heatclient. The purpose is to create a heat client environment.  
4. Create openrc for Openstack environemnt setting. It will be used for heat client.  
5. Install nsenter. The purpose is to enter container (docker) .  
6. Install pipework for docker network utilization. 

After the package installation and setting, you can do the docker programming and testing. Besides, you can run heat template in the VM.
