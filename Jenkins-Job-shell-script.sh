#!/bin/bash

#Sourcing and Passing necessary variables
export PATH=/var/lib/jenkins/.local/bin:$PATH
source /var/lib/jenkins/.aws/CREDS
region=us-east-1
Environment=uptime-test	
VPCID=vpc-56562432	
VPCPublicSubnetA=subnet-04fd7061	
VPCPublicSubnetB=subnet-4604b44a	
login_string=`aws ecr get-login --region us-east-1 --no-include-email`
eval $login_string

#Creating a working Direcory
WORK_DIR=/var/lib/jenkins/workspace/uptime-build
mkdir $WORK_DIR/base_image

#Compiling the Code
gcc -o exercise.exe exercise.c
./exercise.exe


#Tomcat Base Docker Image Creation and pushing to ECR
if [ "$Create_Docker_Base_Image" == "true" ]; then

cp Dockerfile-Base-Image $WORK_DIR/base_image/Dockerfile
docker build -t uptimetomcat9:latest $WORK_DIR/base_image/
docker tag uptimetomcat9:latest 270108075057.dkr.ecr.us-east-1.amazonaws.com/uptimetomcat9:latest
docker push 270108075057.dkr.ecr.us-east-1.amazonaws.com/uptimetomcat9:latest 

fi

#Creation of Uptime Docker Image and Pushing to ECR
cp Dockerfile-Uptime Dockerfile
docker build -t uptime:latest .
docker tag uptime:latest 270108075057.dkr.ecr.us-east-1.amazonaws.com/uptime:$BUILD_NUMBER
docker push 270108075057.dkr.ecr.us-east-1.amazonaws.com/uptime:$BUILD_NUMBER

#Performing the Deployment using AWS Cloudformation by passing the above declared variables and the docker image id created during the build

Image=270108075057.dkr.ecr.us-east-1.amazonaws.com/uptime:$BUILD_NUMBER
aws cloudformation update-stack --stack-name uptime-ecs --template-body file:///var/lib/jenkins/workspace/uptime-build/ecs-cloudformation.yaml --parameters ParameterKey=Image,ParameterValue=$Image ParameterKey=VPCID,ParameterValue=$VPCID ParameterKey=VPCPublicSubnetA,ParameterValue=$VPCPublicSubnetA ParameterKey=VPCPublicSubnetB,ParameterValue=$VPCPublicSubnetB ParameterKey=Environment,ParameterValue=$Environment  --region $region
