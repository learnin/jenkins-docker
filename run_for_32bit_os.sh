#!/bin/bash

# app-data volume
docker volume create --name jenkinsdocker_app-data

# app
docker container run \
  -d \
  -e 'JAVA_OPTS=-Djava.awt.headless=true' \
  -e 'TZ=Asia/Tokyo' \
  --name jenkinsdocker_app_1 \
  -p 50001:8080 \
  -p 50000:50000 \
  --restart always \
  -v /etc/localtime:/etc/localtime:ro \
  -v jenkinsdocker_app-data:/var/jenkins_home \
  jenkinsdocker_app
