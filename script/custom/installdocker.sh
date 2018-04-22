#!/bin/bash -x -e
#This script installs the latest vesion of docker ce on ubuntu 16.04
SSH_USER=${SSH_USERNAME:-vagrant}
SSH_PASS=${SSH_PASSWORD:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}

#first install dependencies
sudo apt-get -y update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
#apt-get update -y
#apt-get upgrade -y
echo "*****Intalling Docker*******"
#apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y update
sudo apt-get -y install docker-ce

# configure docker group and user
# https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
sudo groupadd docker
sudo usermod -aG docker $SSH_USER
newgrp - docker

#Docker Benchmark changes

#echo "***** Install auditd to inspect  auditctl ****"
#apt install -y  auditd
#
#echo "***** Start auditd service  ****"
#service auditd start

#https://devopscube.com/jenkins-master-build-slaves-docker-container/

echo "******Configuring Docker******"
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo touch /etc/systemd/system/docker.service.d/docker_benchmark_security.conf

sudo bash -c "cat << EOL > /etc/systemd/system/docker.service.d/docker_benchmark_security.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -D -H fd:// --icc=false --log-level="info"
EOL"

mkdir "$SSH_USER_HOME/.docker"
touch "$SSH_USER_HOME/.docker/config.json"
chown -R $SSH_USER "$SSH_USER_HOME/.docker"

# allow jenkins to remote in
cat << EOL > "$SSH_USER_HOME/.docker/config.json"
{
    "hosts": ["tcp://127.0.0.1:2376", "unix:///var/run/docker.sock"]
}
EOL

#the following two steps are so that new docker configuration file gets picked up
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl restart docker.service

# post install provision users
# says only for upstart so likely not needed.
sudo bash -c "echo DOCKER_OPTS='-H tcp://127.0.0.1:2376 -H unix:///var/run/docker.sock' >> /etc/default/docker"

#deprovision the VM for image creation
#/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync
