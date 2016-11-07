#!/bin/bash

TAG=${TAG:-$1}
VERSION=5.0.0
strDIR=`basename $PWD`
IMAGE=homesoctokyo/$strDIR:${TAG}
echo ${IMAGE}
git pull

sleep 10s

docker rm `docker ps -a -q`	> /dev/null
docker images | grep none | awk '{print $3}' | xargs docker rmi	> /dev/null


cd $(dirname $0)
docker build --no-cache -t ${IMAGE} ${VERSION}

docker stop test	> /dev/null
docker rm test		> /dev/null

docker run \
--name es0 \
-p 9201:9200 \
-p 9301:9300 \
-e "CLUSTER_NAME=es" \
-e "NODE_NAME=node1" \
-it ${IMAGE}
docker logs -f es0
docker stop es0
docker rm es0