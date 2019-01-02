#!/bin/bash

HOST_IP=${HOST_IP:-$(hostname -I | cut -d ' ' -f1)}
SPARK_MASTER=${SPARK_MASTER:-"local"}
LIVY_PORT=${LIVY_PORT:-"8998"}
LIVY_SESSION_TIMEOUT=${LIVY_SESSION_TIMEOUT:-"2h"}
SPARK_UI_PORT=${SPARK_UI_PORT:-'4040'}
SPARK_DRIVER_PORT=${SPARK_DRIVER_PORT:-"23456"}
SPARK_BLOCKMANAGER_PORT=${SPARK_BLOCKMANAGER_PORT:-"234567"}
LIBPROCESS_PORT=${LIBPROCESS_PORT:-"23458"}

sed s/HOST_IP/$HOST_IP/ /usr/local/spark/conf/spark-env.sh > /usr/local/spark/conf/spark-env.sh
sed s/LIBPROCESS_PORT/$LIBPROCESS_PORT/ /usr/local/spark/conf/spark-env.sh > /usr/local/spark/conf/spark-env.sh

# SPARK_MASTER use `@` as delimiter since most likely it will contains `/`
sed s@SPARK_MASTER@$SPARK_MASTER@ /usr/local/livy/conf/livy.conf > /usr/local/livy/conf/livy.conf
sed s/LIVY_PORT/$LIVY_PORT/ /usr/local/livy/conf/livy.conf > /usr/local/livy/conf/livy.conf
sed s/LIVY_SESSION_TIMEOUT/$LIVY_SESSION_TIMEOUT/ /usr/local/livy/conf/livy.conf > /usr/local/livy/conf/livy.conf

sed s@SPARK_MASTER@$SPARK_MASTER@ /usr/local/spark/conf/spark-defaults.conf > /usr/local/spark/conf/spark-defaults.conf
sed s/SPARK_UI_PORT/$SPARK_UI_PORT/ /usr/local/spark/conf/spark-defaults.conf > /usr/local/spark/conf/spark-defaults.conf
sed s/SPARK_DRIVER_PORT/$SPARK_DRIVER_PORT/ /usr/local/spark/conf/spark-defaults.conf > /usr/local/spark/conf/spark-defaults.conf
sed s/SPARK_BLOCKMANAGER_PORT/$SPARK_BLOCKMANAGER_PORT/ /usr/local/spark/conf/spark-defaults.conf > /usr/local/spark/conf/spark-defaults.conf

/usr/local/livy/bin/livy-server
