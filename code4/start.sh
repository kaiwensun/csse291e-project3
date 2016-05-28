#!/bin/bash

SIGN='\033[1;42mKevin:\033[0m'
PWD=$(pwd)


printf "${SIGN} Creating network bridge\n"
docker network create -d bridge  my-bridge-network

#For the first time, create the containers, with a storage volume mounted from local host ~/cse291/project3/code/data to container /data
#	docker pull sequenceiq/hadoop-docker:2.7.0

printf "${SIGN} Creating containers\n"
docker run -v ${PWD}/data:/data --name Master --net my-bridge-network -td sequenceiq/hadoop-docker:2.7.0 /etc/bootstrap.sh -bash
docker run -v ${PWD}/data:/data --name Slave1 --net my-bridge-network -td sequenceiq/hadoop-docker:2.7.0 /etc/bootstrap.sh -bash
#
#For the following times, you've already have a container hadoopDocker. So simply start it
#docker start -i hadoopDocker

printf "${SIGN} Configuring Master's slaves\n"
docker exec Master "echo Slave1 > \$HADOOP_PREFIX/etc/hadoop/slaves"

