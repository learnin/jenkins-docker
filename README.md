# jenkins-docker

## Getting started

### When using Docker Compose
```shell
export http_proxy=http://your_proxy_host:your_proxy_port/
export https_proxy=http://your_proxy_host:your_proxy_port/
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export no_proxy=`docker-machine ip default`
export NO_PROXY=$no_proxy

docker-compose up -d
```
### When not using Docker Compose(e.g. Windows 32bit)
```shell
export http_proxy=http://your_proxy_host:your_proxy_port/
export https_proxy=http://your_proxy_host:your_proxy_port/
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export no_proxy=`docker-machine ip default`
export NO_PROXY=$no_proxy

docker-machine scp run_for_32bit_os.sh default:/tmp/jenkins_run_for_32bit_os.sh
docker-machine ssh default
sh /tmp/jenkins_run_for_32bit_os.sh
rm -f /tmp/jenkins_run_for_32bit_os.sh
```

# For developers

## How to build and run

### When using Docker Compose
```shell
export http_proxy=http://your_proxy_host:your_proxy_port/
export https_proxy=http://your_proxy_host:your_proxy_port/
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export no_proxy=`docker-machine ip default`
export NO_PROXY=$no_proxy

docker-compose build
docker-compose up -d
```
### When not using Docker Compose(e.g. Windows 32bit)
```shell
export http_proxy=http://your_proxy_host:your_proxy_port/
export https_proxy=http://your_proxy_host:your_proxy_port/
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export no_proxy=`docker-machine ip default`
export NO_PROXY=$no_proxy

docker image build -t jenkinsdocker_app \
  --build-arg http_proxy=$http_proxy \
  --build-arg https_proxy=$https_proxy \
  .

docker volume create --name jenkinsdocker_app-data

docker-machine ssh default

docker container run \
  -d \
  -e 'JAVA_OPTS=-Djava.awt.headless=true' \
  -e 'TZ=Asia/Tokyo' \
  --name jenkinsdocker_app_1 \
  -p 50001:8080 \
  -p 50000:50000 \
  --restart unless-stopped \
  -v /etc/localtime:/etc/localtime:ro \
  -v jenkinsdocker_app-data:/var/jenkins_home \
  jenkinsdocker_app
```
