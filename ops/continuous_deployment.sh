#!/bin/bash

# Go to root directory of project (from whereever you are)
cd /home/pi/intellicatflap/

# Pull from pi_deployment branch of repository
git fetch --all && git checkout "pi_deployment" && git pull 

# Quit service
docker-compose down -v

# Make sure every default network is removed
docker network rm $(docker network ls -f 'name=intellicatflap_default' -q)

# Rebuild service
docker-compose up -d --build

# Write log
USR=$(whoami)
DAT=$(date +"%F %R ")
echo "$DAT$USR: Completed cronjob!" >> /home/pi/intellicatflap/logs/operation.log
