FROM centos:7

COPY start-slave.sh /root/start-slave.sh

WORKDIR /root

RUN rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm && \
    yum -y install mesos && \
    yum install -y java-1.8.0-openjdk && \
    curl https://www-eu.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz -o spark.tgz && \
    tar -zxf spark.tgz && \
    rm spark.tgz && \
    mv spark*/ spark

EXPOSE 5051

ENTRYPOINT ["/root/start-slave.sh"]