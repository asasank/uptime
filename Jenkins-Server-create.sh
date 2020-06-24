#!/bin/bash

#Essential Services Installation
yum update -y
yum remove podman
yum install java python38 gcc wget tar git yum-utils iptables -y 
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

#AWS CLI Installation 
curl -O https://bootstrap.pypa.io/get-pip.py
python3.8 get-pip.py --user
export PATH=~/.local/bin:$PATH
source ~/.bash_profile
pip3 install awscli --upgrade --user

#Jenkins Installation
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y 
systemctl start jenkins
systemctl enable jenkins
wget https://download.docker.com/linux/static/stable/x86_64/docker-18.09.0.tgz
tar xzvf docker-18.09.0.tgz
sudo cp docker/* /usr/bin/
usermod -aG docker $USER
sudo dockerd &

