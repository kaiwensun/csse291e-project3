#!/bin/bash

SIGN='\033[1;42mKevin:\033[0m'
PWD=$(pwd)
XML='/data/xml/core-site.xml  /data/xml/hdfs-site.xml  /data/xml/mapred-site.xml  /data/xml/masters  /data/xml/slaves'



printf "${SIGN} Making sure docker containers don't conflict\n"
${PWD}/clean.sh

printf "${SIGN} Creating network bridge\n"
docker network create -d bridge  my-bridge-network

#For the first time, create the containers, with a storage volume mounted from local host ~/cse291/project3/code/data to container /data
#	docker pull sequenceiq/hadoop-docker:2.7.0

printf "${SIGN} Creating containers\n"
docker run -v ${PWD}/data:/data -e HADOOP_CLASSPATH=/usr/java/default/lib/tools.jar --name Master --net my-bridge-network -td sequenceiq/hadoop-docker:2.7.0 bash
docker run -v ${PWD}/data:/data --name Slave1 --net my-bridge-network -td sequenceiq/hadoop-docker:2.7.0 bash
docker run -v ${PWD}/data:/data --name Slave2 --net my-bridge-network -td sequenceiq/hadoop-docker:2.7.0 bash
docker run -v ${PWD}/data:/data --name Slave3 --net my-bridge-network -td sequenceiq/hadoop-docker:2.7.0 bash
docker run -v ${PWD}/data:/data --name Slave4 --net my-bridge-network -td sequenceiq/hadoop-docker:2.7.0 bash
#
#For the following times, you've already have a container hadoopDocker. So simply start it
#docker start -i hadoopDocker


printf "${SIGN} Starting SSH connection (try multiple times, because sometimes it fails to start)\n"
docker exec -t Master service sshd start
docker exec -t Slave1 service sshd start
docker exec -t Slave2 service sshd start
docker exec -t Slave3 service sshd start
docker exec -t Slave4 service sshd start

docker exec -t Master service sshd start
docker exec -t Slave1 service sshd start
docker exec -t Slave2 service sshd start
docker exec -t Slave3 service sshd start
docker exec -t Slave4 service sshd start

docker exec -t Master service sshd start
docker exec -t Slave1 service sshd start
docker exec -t Slave2 service sshd start
docker exec -t Slave3 service sshd start
docker exec -t Slave4 service sshd start

printf "${SIGN} Creating meta directories for naming and data at Master\n"
docker exec -t Master mkdir -p /usr/local/hadoop/hdfs/name
docker exec -t Master mkdir -p /usr/local/hadoop/hdfs/data

printf "${SIGN} Copying hadoop config files to master and slaves\n"
docker exec -t Master cp ${XML} /usr/local/hadoop/etc/hadoop/
docker exec -t Slave1 cp ${XML} /usr/local/hadoop/etc/hadoop/
docker exec -t Slave2 cp ${XML} /usr/local/hadoop/etc/hadoop/
docker exec -t Slave3 cp ${XML} /usr/local/hadoop/etc/hadoop/
docker exec -t Slave4 cp ${XML} /usr/local/hadoop/etc/hadoop/

printf "${SIGN} Formatting HDFS\n"
docker exec -t Master /usr/local/hadoop/bin/hadoop namenode -format

printf "${SIGN} Executing start-all.sh\n"
docker exec -t Master /usr/local/hadoop/sbin/start-all.sh

printf "${SIGN} Executing run_sample_wordcount.sh at Master\n"
docker exec -t Master /data/run_sample_wordcount.sh

#printf "${SIGN} Cleaning containers\n"
#${PWD}/clean.sh
