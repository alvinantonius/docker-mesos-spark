#!/bin/bash
PRIVATE_IP=$(hostname -i)
docker rm -f mesos_slave
docker run -i --privileged --restart=always --net=host --name mesos_slave \
  -e MESOS_PORT=5051 \
  -e MESOS_HOSTNAME_LOOKUP=false \
  -e MESOS_IP=$PRIVATE_IP \
  -e MESOS_WORK_DIR=/var/log/mesos_slave/ \
  -e MESOS_CONTAINERIZERS=docker,mesos \
  -e MESOS_IMAGE_PROVIDERS=docker \
  -e MESOS_ISOLATION=filesystem/linux,docker/runtime \
  -e MESOS_MASTER=zk://data-master-01.honestbee.com:2181,data-master-02.honestbee.com:2181,data-master-03.honestbee.com:2181/mesos \
  -e MESOS_ATTRIBUTES='type:autoscaling' \
  -e MESOS_EXECUTOR_REGISTRATION_TIMEOUT=5mins \
  -v "/var/log/mesos:/var/log/mesos" \
  -v "/var/tmp/mesos:/var/tmp/mesos" \
  -v "/home/ubuntu/mesos/worker/:/home/ubuntu/mesos/worker/" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /cgroup:/cgroup \
  -v /sys:/sys \
  -v /usr/bin/docker:/usr/local/bin/docker \
  -v /lib/x86_64-linux-gnu/libsystemd.so.0:/lib/x86_64-linux-gnu/libsystemd.so.0 \
  -v /lib/x86_64-linux-gnu/libselinux.so.1:/lib/x86_64-linux-gnu/libselinux.so.1 \
  -v /lib/x86_64-linux-gnu/libgcrypt.so.20:/lib/x86_64-linux-gnu/libgcrypt.so.20 \
  -v /lib/x86_64-linux-gnu/libgpg-error.so.0:/lib/x86_64-linux-gnu/libgpg-error.so.0 \
  -v /usr/lib/x86_64-linux-gnu/libltdl.so.7:/usr/lib/x86_64-linux-gnu/libltdl.so.7 \
  -v /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:/lib/x86_64-linux-gnu/libdevmapper.so.1.02.1:ro \
  -v /lib/x86_64-linux-gnu/libapparmor.so.1:/usr/lib/x86_64-linux-gnu/libapparmor.so.1:ro \
  -v /lib/x86_64-linux-gnu/libseccomp.so.2:/usr/lib/x86_64-linux-gnu/libseccomp.so.2:ro \
  -v /data/mesos_slave:/var/log/mesos_slave/ \
  mesosphere/mesos-slave:1.7.0