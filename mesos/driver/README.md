## How to use this image

```
docker run -d --net=host --restart=always \
    -e HOST_IP=<IP> \
    -e SPARK_MASTER=<spark-master-host> \
    --name=<container-name> <image name>
```

## Environment Variables

**`HOST_IP`**
set this variable to your machine IP

**`SPARK_MASTER`**
default is `local`. to use mesos/zookeeper put `mesos://zk://[zookeeper-hosts]/mesos`

**`LIVY_PORT`**
default is `8998`.

**`SPARK_UI_PORT`**
default is `4040`.

**`SPARK_DRIVER_PORT`**
default is `23456`.

## Volumes

**`Spark Logs`**

attach volume to `/usr/local/spark/log` to bind the log into your filesystem

**`Spark Configs`**

attach volume to `/usr/local/spark/conf` to bind the configs into your filesystem and to make the container more configurable

**`Livy Log`**

attach volume to `/usr/local/livy/log` to bind the log into your filesystem

**`Livy Configs`**

attach volume to `/usr/local/livy/conf` to bind the configs into your filesystem and to make the container more configurable
