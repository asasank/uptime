#!/bin/bash

#Essential Services Installation

yum install java python38 gcc wget tar -y 

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
