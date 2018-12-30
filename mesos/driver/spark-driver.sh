#!/bin/bash

#need to dockerize this

ZOOKEEPER=${1:-"127.0.0.1:2181"}
HOST_IP="$(hostname -I | cut -d ' ' -f1)"

echo "install JAVA"
yum install -y java-1.8.0-openjdk

echo "Installing MESOS"
rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
yum -y install mesos

echo "downloading spark"
cd
curl https://www-eu.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz -o spark.tgz
tar -zxf spark.tgz
rm spark.tgz
mv spark*/ spark

cat <<EOT >> ~/spark/conf/spark-defaults.conf
spark.master mesos://zk://$ZOOKEEPER/mesos 
spark.mesos.executor.home /usr/local/spark
#spark.eventLog.enabled true
#spark.eventLog.dir /root/sparklog
#spark.driver.port 45678
#spark.blockManager.port 45679
#spark.executor.instances 1
#spark.driver.blockManager.port 45679
#spark.broadcast.port       38001
#spark.fileserver.port      38004
#spark.replClassServer.port 38005
#spark.executor.memory 1g
#spark.cores.max 2
EOT

cat <<EOT >> ~/spark/conf/spark-env.sh
SPARK_LOCAL_IP=$HOST_IP
LIBPROCESS_IP=$HOST_IP
MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so
EOT
