#!/bin/bash
SIGN='\033[1;42mKevin:\033[0m'
ALLHOSTS='Master Slave1'

printf "${SIGN} Stopping containers\n"
docker stop ${ALLHOSTS}

printf "${SIGN} Removing network bridge\n"
docker network rm my-bridge-network

printf "${SIGN} Removing docker containers\n"
docker rm ${ALLHOSTS}
