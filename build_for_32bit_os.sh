#!/bin/bash

docker image build -t jenkinsdocker_app \
  --build-arg http_proxy=$http_proxy \
  --build-arg https_proxy=$https_proxy \
  .
