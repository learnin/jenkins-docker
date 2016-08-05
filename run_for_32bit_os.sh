#!/bin/bash

# master-data volume
docker volume create --name jenkinsdocker_master-data

# master
docker run \
  -d \
  -e 'JAVA_OPTS=-Djava.awt.headless=true' \
  -e 'TZ=Asia/Tokyo' \
  --name jenkinsdocker_master_1 \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /etc/localtime:/etc/localtime:ro \
  -v jenkinsdocker_master-data:/var/jenkins_home \
  jenkinsdocker_master
