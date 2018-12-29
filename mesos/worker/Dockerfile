FROM centos:7

ENV APP_HOME /app

RUN mkdir -p $APP_HOME

COPY entrypoint.sh $APP_HOME

# Spark related variables.
ARG SPARK_VERSION=2.4.0
ARG SPARK_ARCHIVE_NAME=spark-${SPARK_VERSION}-bin-hadoop2.7
ARG SPARK_DOWNLOAD_URL=http://www-eu.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE_NAME}.tgz

WORKDIR $APP_HOME

RUN rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm && \
    yum -y install mesos && \
    yum install -y java-1.8.0-openjdk && \
    curl -L ${SPARK_DOWNLOAD_URL} | tar -xz -C /usr/local/ && \
    cd /usr/local && ln -s ${SPARK_ARCHIVE_NAME} spark

EXPOSE 5051

ENTRYPOINT ["/app/entrypoint.sh"]
