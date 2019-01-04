#!/bin/bash
IP=$(hostname -i)
SPARK_MASTER=mesos://zk://[zookeeper-hosts]/mesos
docker rm -f spark_driver
docker run -d --name=spark_driver -i \
	-e HOST_IP=$IP \
	-e SPARK_MASTER=$SPARK_MASTER spark_driver
