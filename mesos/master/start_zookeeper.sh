#!/bin/bash
export IP=$(hostname -i)
docker rm -f zookeeper
docker run --name=zookeeper -i \
    -p 8181:8181 \
    -p 2181:2181 \
    -p 2888:2888 \
    -p 3888:3888 \
    -e ZK_PASSWORD=testgrabpay \
    -e HOSTNAME=$IP \
mbabineau/zookeeper-exhibitor:latest