#!/bin/sh
#
#For the first time, create the container hadoopDocker, with a storage volume mounted from local host ~/cse291/project3/code/data to container /data
#	docker pull sequenceiq/hadoop-docker:2.7.0
#	docker run -v ~/cse291/project3/code/data:/data --name hadoopDocker -it sequenceiq/hadoop-docker:2.7.0 /etc/bootstrap.sh -bash
#
#For the following times, you've already have a container hadoopDocker. So simply start it
docker start -i hadoopDocker

