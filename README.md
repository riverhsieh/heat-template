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
If you want to see these templates, please go ahead and take a look at them in my GitHub repository. Here are lib/mysql.yaml and lib/wordpress.yaml.  

$ heat stack-create _stack_name_ -f heat_3a.yaml  

**D. heat_4a.yaml**  
Using heat environment, the heat command line client is pretty smart, it finds all the nested template references in the master template and then uploads all the needed files to Heat as a package.  
But Horizon does not have the ability to do that, any templates that reference other templates, cannot be launched from the web dashboard. An alternative way to nest templates called environments, which Horizon supports. An environment file is a YAML file that has global definitions that are imported before a template is parsed. (See _lib/env.yaml_)  
To download _heat_4a.yaml_ and _lib/env.yaml_, and load both in Horizon's launch stack dialog.  

$ heat stack-create _stack_name_ -f heat_4a.yaml -e lib/env.yaml  

