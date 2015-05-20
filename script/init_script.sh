#!/bin/bash
export ip_port=10.110.15.60:8080
export http_proxy=http://$ip_port
export https_proxy=https://$ip_port

echo 127.0.1.1 server-01 >> /etc/hosts
cat > /etc/apt/apt.conf.d/01proxy << EOF
Acquire::http::Proxy "$http_proxy";
Acquire::https::Proxy "$https_proxy";
EOF

apt-get update

apt-get install -y apt-transport-https git socat connect-proxy python2.7-dev python-virtualenv 
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y lxc-docker
sed -i "s|127.0.0.1:3128|$ip_port|" /etc/default/docker
sed -i 's/^#export http/export http/' /etc/default/docker
service docker restart

cat >/home/ubuntu/openrc <<EOF
#!/bin/sh
export LC_ALL=C
export OS_NO_CACHE='true'
export OS_TENANT_NAME='admin'
export OS_USERNAME='admin'
export OS_PASSWORD='admin'
export OS_AUTH_URL='http://192.168.0.3:5000/v2.0/'
export OS_AUTH_STRATEGY='keystone'
EOF
chmod 644 /home/ubuntu/openrc

cat >/home/ubuntu/nsenter.sh <<EOF
#!/bin/sh
curl https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz | tar -zxf-
cd util-linux-2.24
./configure --without-ncurses
make nsenter
sudo cp nsenter /usr/local/bin
cd ..
git config --global http.proxy $http_proxy
git config --global https.proxy $https_proxy
git clone https://github.com/jpetazzo/pipework.git
EOF
chmod 755 /home/ubuntu/nsenter.sh

cat >/home/ubuntu/docker_enter <<EOF
#!/bin/sh
wget -P ~ https://github.com/yeasy/docker_practice/raw/master/_local/.bashrc_docker;
echo "[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker" >> ~/.bashrc; source ~/.bashrc
PID=\$(docker inspect --format '{{.State.Pid}}' my_container_id)
nsenter --target \$PID --mount --uts --ipc --net --pid
EOF
chmod 644 /home/ubuntu/docker_enter

cat >/home/ubuntu/python_venv <<EOF
#!/bin/sh
virtualenv venv
source venv/bin/activate
pip --proxy $http_proxy install python-heatclient
pip --proxy $http_proxy install python-novaclient
pip --proxy $http_proxy install python-neutronclient
EOF
chmod 644 /home/ubuntu/python_venv

chown -R ubuntu:ubuntu /home/ubuntu/

echo export http_proxy=$http_proxy >> /etc/profile
echo export https_proxy=$https_proxy >> /etc/profile
echo export PIP_REQUIRE_VIRTUALENV=true >> /etc/profile
echo export PIP_RESPECT_VIRTUALENV=true >> /etc/profile
