#!/bin/bash

PORT=${MESOS_PORT:-5051}
WORK_DIR=${MESOS_WORK_DIR:-"/var/tmp/mesos_slave"}
LOG_DIR=${MESOS_LOG_DIR:-"/var/log/mesos_slave"}
MASTER=${MESOS_MASTER:-""}
HOSTNAME_LOOKUP=${MESOS_HOSTNAME_LOOKUP:-false}
IP=${MESOS_IP:-$(hostname -I | cut -d ' ' -f1)}

mesos-slave \
--port=$PORT \
--work_dir=$WORK_DIR \
--log_dir=$LOG_DIR \
--master=$MASTER \
--systemd_enable_support=false \
--hostname_lookup=$HOSTNAME_LOOKUP \
--ip=$IP


