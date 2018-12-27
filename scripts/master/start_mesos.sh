#!/bin/bash
export PRIVATE_IP=$(hostname -i)
CONTAINER_NAME=mesos_master
docker rm -f $CONTAINER_NAME
docker run -i --restart=always --net=host --name $CONTAINER_NAME \
    -e MESOS_PORT=5050 \
    -e MESOS_ZK=zk://$PRIVATE_IP:2181/mesos \
    -e MESOS_QUORUM=2 -e MESOS_REGISTRY=in_memory \
    -e MESOS_CLUSTER=mesos -e MESOS_HOSTNAME_LOOKUP=false \
    -e MESOS_IP=$PRIVATE_IP -e MESOS_WORK_DIR=/var/tmp/mesos \
    -v /data/mesos:/var/tmp/mesos \
mesosphere/mesos-master:1.7.0