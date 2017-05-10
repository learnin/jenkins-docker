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

## How to backup
```shell
docker container run \
  --rm \
  -v jenkinsdocker_app-data:/target/jenkins-data \
  -v $(pwd):/backup \
  ubuntu tar cvzfp /backup/backup.tar.gz /target
```

If you use docker-machine, execute the above command in docker-machine, and copy backup.tar.gz from docker-machine to host machine with the following command.

```shell
docker-machine scp default:~/backup.tar.gz .
```

## How to restore
```shell
docker container run \
  --rm \
  -v jenkinsdocker_app-data:/target/jenkins-data \
  -v $(pwd):/backup \
  ubuntu bash -c "cd /target && tar xvzfp /backup/backup.tar.gz --strip 1"
```

If you use docker-machine, execute the following command to copy backup.tar.gz from host machine to docker-machine, and execute the above command in docker-machine.

```shell
docker-machine scp backup.tar.gz default:~/
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

docker-compose -f docker-compose-build.yml build
docker-compose -f docker-compose-build.yml up -d
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
