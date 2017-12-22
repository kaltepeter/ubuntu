#!/bin/bash -x -e
#This script installs the latest vesion of docker ce on ubuntu 16.04

#first install docker
apt-get update -y
apt-get upgrade -y
echo "*****Intalling Docker*******"
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce

#Docker Benchmark changes

echo "***** Install auditd to inspect  auditctl ****"
apt install -y  auditd

echo "***** Start auditd service  ****"
service auditd start

echo "******Configuring Docker******"
rm -rf /etc/systemd/system/docker.service.d
mkdir -p /etc/systemd/system/docker.service.d

cat > /etc/systemd/system/docker.service.d/docker_benchmark_security.conf << EOL
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// --icc=false --log-level="info" --disable-legacy-registry
EOL

#the following two steps are so that new docker configuration file gets picked up
systemctl daemon-reload
systemctl enable docker
systemctl restart docker.service

# post install provision users
#sudo groupadd docker
#sudo usermod -aG docker $USER
# https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
sudo gpasswd -a $USER docker
newgrp docker
# http://container-solutions.com/running-docker-in-jenkins-in-docker/
#sudo sh -c "echo 'vagrant ALL=NOPASSWD: ALL' >> /etc/sudoers"
#sudo sh -c "echo 'includedir /etc/sudoers.d' >> /etc/sudoers"
sudo sh -c "echo DOCKER_OPTS='-H tcp://127.0.0.1:2376 -H unix:///var/run/docker.sock'" >> /etc/default/docker


#deprovision the VM for image creation
#/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync
