#!/bin/bash
ZOOKEEPER=${1:-"zk://localhost:2181/mesos"}
ZOO_CONFIG=${2:-"server.1=localhost:2888:3888 server.2=localhost:2888:3888"}
ZOO_MY_ID=${3:-"1"}
ZOO_LOG_DIR=${4:-"/var/log/zookeeper"}
HOST_IP="$(hostname -I | cut -d ' ' -f1)"

echo "spin zookeeper"
docker rm -f zookeeper
docker run -d --name=zookeeper --restart always \
    -p 2181:2181 -p 2888:2888 -p 3888:3888\
    -e ZOO_MY_ID=$ZOO_MY_ID \
    -e ZOO_SERVERS=$ZOO_CONFIG \
    -e ZOO_LOG4J_PROP="WARN,ROLLINGFILE" \
    -v "$ZOO_LOG_DIR:/logs" \
    zookeeper:3.5

echo "install and run mesos master"
docker rm -f mesos_master
docker run -d --net=host --name=mesos_master \
  -e MESOS_PORT=5050 \
  -e MESOS_ZK=zk://$ZOOKEEPER:2181/mesos \
  -e MESOS_QUORUM=1 \
  -e MESOS_REGISTRY=in_memory \
  -e MESOS_LOG_DIR=/var/log/mesos \
  -e MESOS_WORK_DIR=/var/tmp/mesos \
  -e MESOS_HOSTNAME_LOOKUP=false \
  -e MESOS_IP=$HOST_IP \
  -e MESOS_HOSTNAME=$HOST_IP \
  -v "/var/log/mesos:/var/log/mesos" \
  -v "/var/tmp/mesos:/var/tmp/mesos" \
  mesosphere/mesos-master:1.7.0
