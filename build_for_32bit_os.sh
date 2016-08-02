#!/bin/bash

docker build -t jenkinsdocker_master \
  --build-arg http_proxy=$http_proxy \
  --build-arg https_proxy=$http_proxy \
  .
