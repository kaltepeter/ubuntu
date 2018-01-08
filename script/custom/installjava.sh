#!/bin/bash -x -e
#https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
sudo apt-get update -y
sudo apt-get upgrade -y
#This script installs jdk8 on ubuntu 16.04
sudo apt-get -y install default-jdk
#sudo apt-get -y install openjdk-8-jre-headless
#sudo apt-get -y install openjdk-8-jdk