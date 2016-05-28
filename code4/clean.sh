#!/bin/bash
SIGN='\033[1;42mKevin:\033[0m'
ALLHOSTS='Master Slave1 Slave2 Slave3 Slave4'

printf "${SIGN} Stopping conflicting containers\n"
docker stop -t 0 ${ALLHOSTS}

printf "${SIGN} Removing network bridge\n"
docker network rm my-bridge-network

printf "${SIGN} Removing docker containers\n"
docker rm ${ALLHOSTS}
