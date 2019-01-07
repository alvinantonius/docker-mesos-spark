#!/bin/bash
export IP=$(hostname -i)
docker rm -f zookeeper
docker run --name=zookeeper -i \
    -p 31000:8181 \
    -p 2181:2181 \
    -p 2888:2888 \
    -p 3888:3888 \
    -e ZK_PASSWORD=testgrabpay \
    -e HOSTNAME=10.66.5.135 \
mbabineau/zookeeper-exhibitor:latest