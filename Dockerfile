FROM ubuntu:16.04

USER root

# update system
RUN apt-get update && \
	apt-get -y install software-properties-common python-software-properties && \
	add-apt-repository ppa:openjdk-r/ppa -y && \
	apt update && \
	apt -y install openjdk-7-jre openssl openssh-client openssh-server rsync sudo vim python3 python3-pip git

# RUN ln -s /usr/bin/python3 /usr/bin/python

# Create hadoop user
RUN adduser --disabled-password --gecos '' hadoop
RUN adduser hadoop sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER hadoop
WORKDIR /home/hadoop

ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# setup ssh with no passphrase
RUN ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -P '' \
    && cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

# Install hadoop
RUN echo "Install hadoop"
COPY hadoop-2.8.4 /usr/local/hadoop-2.8.4
RUN sudo chown -R hadoop:hadoop /usr/local/hadoop-2.8.4
RUN sudo ln -s /usr/local/hadoop-2.8.4 /usr/local/hadoop

# Hadoop env variables
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

ENV HADOOP_PREFIX=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR=$HADOOP_PREFIX/etc/hadoop

# Configure hadoop
COPY configs/ /tmp/
RUN sudo chown -R hadoop:hadoop /tmp
RUN cp /tmp/ssh_config $HOME/.ssh/config \
	&& cp /tmp/hadoop-env.sh $HADOOP_CONF_DIR/hadoop-env.sh \
	&& cp /tmp/core-site.xml $HADOOP_CONF_DIR/core-site.xml \
	&& cp /tmp/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml \
	&& cp /tmp/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml \
	&& cp /tmp/yarn-site.xml $YARN_CONF_DIR/yarn-site.xml

# set permissions
RUN chmod 744 -R $HADOOP_HOME

# format HDFS
RUN $HADOOP_HOME/bin/hdfs namenode -format

# ResourceManager WebUI
EXPOSE 8088
# NameNode WebUI
EXPOSE 50070
# JobTracker WebUI
EXPOSE 50030
# MapReduce JobHistory Server
EXPOSE 19888


COPY bootstrap.sh /tmp/
ENTRYPOINT /tmp/bootstrap.sh; bash
