# Apache Hadoop 
#
# VERSION:
# 	Ubuntu: 16.04
#	Java:	1.8
#	Hadoop:	2.8.4
#	Python:	3.5.5

FROM ubuntu:16.04

LABEL maintainer="Shu Yan <yanshu.usc@gmail.com>"
LABEL description="This image sets up a single-node hadoop cluster in a pseudo-distributed mode"

USER root

# update system
RUN	apt update \
	&& apt -y install openjdk-8-jdk openssh-client openssh-server rsync sudo vim git python python-pip python3 python3-pip

# Create hadoop user
RUN adduser --disabled-password --gecos '' hadoop
RUN adduser hadoop sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER hadoop
WORKDIR /home/hadoop

# setup ssh with no passphrase
RUN ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -P '' \
    && cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Install Hadoop
RUN echo "Installing Hadoop..."
COPY configs/ /conf/
COPY hadoop-2.8.4 /usr/local/hadoop-2.8.4

# Hadoop env variables
ENV HADOOP_HOME=/usr/local/hadoop-2.8.4
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

ENV HADOOP_PREFIX=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR=$HADOOP_CONF_DIR
ENV HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar

# Configure hadoop
RUN sudo chown -R hadoop:hadoop /usr/local/hadoop-2.8.4
RUN sudo ln -s /usr/local/hadoop-2.8.4 /usr/local/hadoop

RUN cp /conf/ssh_config $HOME/.ssh/config \
	&& cp /conf/hadoop-env.sh $HADOOP_CONF_DIR/hadoop-env.sh \
	&& cp /conf/core-site.xml $HADOOP_CONF_DIR/core-site.xml \
	&& cp /conf/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml \
	&& cp /conf/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml \
	&& cp /conf/yarn-site.xml $YARN_CONF_DIR/yarn-site.xml

# set permissions
RUN chmod 744 -R $HADOOP_HOME

# format HDFS
RUN $HADOOP_HOME/bin/hdfs namenode -format

# ResourceManager WebUI
EXPOSE 8088
# NameNode/DataNode WebUI
EXPOSE 50070
EXPOSE 50075
# JobTracker/TaskTracker WebUI
EXPOSE 50030
EXPOSE 50060
# MapReduce JobHistory Server
EXPOSE 19888

# install mrjob
RUN pip3 install mrjob

ENTRYPOINT /conf/bootstrap.sh; bash
