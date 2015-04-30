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

$ heat stack-create _stack_name_ -f vm_net_router.yaml

**B. two_vm_net_sh.yaml**  
Create two instances using the original private network, router, but using "_get_file: script/init_script.sh_" in user_data for server-01.  
The advantage of this case is to leverage the traditional shell script.  

$ heat stack-create _stack_name_ -f two_vm_net_sh.yaml

**C. heat_3a.yaml**  
Using nested template, Simply create a resource that has its type set to the YAML file of the sub-template. If we assume that there is a template called _lib/mysql.yaml_ at our disposal that creates a MySQL server, then this is how a master template can invoke it:
