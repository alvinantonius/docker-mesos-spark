FROM centos:7

COPY start-slave.sh /root/start-slave.sh

# Spark related variables.
ARG SPARK_VERSION=2.4.0
ARG SPARK_ARCHIVE_NAME=spark-${SPARK_VERSION}-bin-hadoop2.7
ARG SPARK_DOWNLOAD_URL=http://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE_NAME}.tgz

WORKDIR /root

RUN rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm && \
    yum -y install mesos && \
    yum install -y java-1.8.0-openjdk && \
    curl ${SPARK_DOWNLOAD_URL} -o spark.tgz && \
    tar -zxf spark.tgz && \
    rm spark.tgz && \
    mv spark*/ spark

ENV SPARK_HOME /usr/local/spark
ENV PATH $SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

EXPOSE 5051

ENTRYPOINT ["/root/start-slave.sh"]
