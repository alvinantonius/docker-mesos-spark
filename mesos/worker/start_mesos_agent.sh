#!/bin/bash
PRIVATE_IP=$(hostname -i)
docker rm -f mesos_slave
docker run -i --privileged --restart=always --net=host --name mesos_slave \
  -e MESOS_PORT=5051 \
  -e MESOS_HOSTNAME_LOOKUP=false \
  -e MESOS_IP=$PRIVATE_IP\
  -e MESOS_WORK_DIR=/var/log/mesos_slave/ \
  -e MESOS_ISOLATION=filesystem/linux,docker/runtime \
  -e MESOS_MASTER=zk://172.28.128.3:2181/mesos \
  -e MESOS_ATTRIBUTES='type:autoscaling' \
  -e MESOS_EXECUTOR_REGISTRATION_TIMEOUT=5mins \
  -v "/var/log/mesos:/var/log/mesos" \
  -v "/var/tmp/mesos:/var/tmp/mesos" \
  -v /cgroup:/cgroup \
  -v /sys:/sys \
  -v /usr/bin/docker:/usr/local/bin/docker mesos_spark_slave
  