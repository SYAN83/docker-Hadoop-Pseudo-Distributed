# Apache Hive 
#
# VERSION:
#	Tez:	0.9.1
#	Hive:	2.3.3
#	Pig:	0.17.0

FROM hadoop-core

LABEL maintainer="Shu Yan <yanshu.usc@gmail.com>"
LABEL description="This image sets up a hadoop cluster with tez/hive/pig"

USER hadoop

# Install Mysql
RUN sudo apt update \
	&& sudo DEBIAN_FRONTEND=noninteractive apt -y install mysql-server \
	&& sudo usermod -d /var/lib/mysql/ mysql \
	&& echo 'validate_password_policy=LOW' >> sudo /etc/mysql/my.cnf


# Install maven
RUN echo 'Installing maven'
RUN sudo apt update && \
	sudo apt -y install maven autoconf libtool

# Install protobuf
RUN echo 'Installing protobuf'
COPY protobuf-2.5.0 /home/hadoop/protobuf-2.5.0
RUN sudo chown -R hadoop:hadoop /home/hadoop/protobuf-2.5.0 \
	&& cd /home/hadoop/protobuf-2.5.0 \
	&& chmod +x autogen.sh && ./autogen.sh \
	&& chmod +x configure && ./configure --prefix=/usr \
	&& make && sudo make install \
	&& rm -r /home/hadoop/protobuf-2.5.0

COPY configs/ /conf/

# Install tez
RUN echo 'Installing Tez'

ENV TEZ_CONF_DIR=$HADOOP_CONF_DIR
ENV TEZ_HOME=/usr/local/apache-tez-0.9.1-src
ENV TEZ_JARS=$TEZ_HOME
ENV HADOOP_CLASSPATH=${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*

COPY apache-tez-0.9.1-src $TEZ_HOME
RUN sudo chown -R hadoop:hadoop /usr/local/apache-tez-0.9.1-src \
	&& sudo ln -s $TEZ_HOME /usr/local/tez \
	&& cp /conf/pom.xml /usr/local/tez/pom.xml \
	&& cp /conf/tez-site.xml $TEZ_CONF_DIR/tez-site.xml \
	&& cp /conf/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml \
	&& cd $TEZ_HOME \
	&& mvn clean install -DskipTests=true -Dmaven.javadoc.skip=true \
	&& tar xzvf tez-dist/target/tez-0.9.1-minimal.tar.gz -C $TEZ_JARS

# Install Pig
RUN echo 'Installing Pig'

ENV PIG_HOME=/usr/local/pig-0.17.0
ENV PIG_CONF_DIR=$PIG_HOME/conf
ENV PIG_CLASSPATH=$HADOOP_CLASSPATH/HADOOP_CONF_DIR
ENV PATH=$PATH:$PIG_HOME/bin

COPY pig-0.17.0 $PIG_HOME
RUN sudo chown -R hadoop:hadoop $PIG_HOME \
	&& sudo ln -s $PIG_HOME /usr/local/pig \ 
	&& cp /conf/pig.properties $PIG_CONF_DIR/pig.properties

# Install Zookeeper
RUN echo 'Installing Zookeeper'

ENV ZOOKEEPER_HOME=/usr/local/zookeeper-3.4.12
ENV PATH=$PATH:$ZOOKEEPER_HOME/bin

COPY zookeeper-3.4.12 $ZOOKEEPER_HOME
RUN sudo chown -R hadoop:hadoop $ZOOKEEPER_HOME \
	&& sudo ln -s $ZOOKEEPER_HOME /usr/local/zookeeper \ 
	&& cp /conf/zoo.cfg $ZOOKEEPER_HOME/conf/zoo.cfg \
	&& sudo mkdir -p /var/lib/zookeeper \
	&& sudo chown -R hadoop /var/lib/zookeeper


# Install Hive
RUN echo 'Installing Hive'

ENV HIVE_HOME=/usr/local/apache-hive-2.3.3-bin
ENV HIVE_CONF_DIR=$HIVE_HOME/conf
ENV PATH=$PATH:$HIVE_HOME/bin

COPY apache-hive-2.3.3-bin $HIVE_HOME
RUN sudo chown -R hadoop:hadoop $HIVE_HOME \
	&& sudo ln -s $HIVE_HOME /usr/local/hive \
	&& cp /conf/hive-site.xml $HIVE_CONF_DIR/hive-site.xml 


# Install mysql connector
ENV mysql_conn_var=8.0.12
RUN sudo dpkg -i /conf/mysql-connector-java_${mysql_conn_var}-1ubuntu16.04_all.deb \
 	&& sudo apt install -f \
 	&& sudo ln -s /usr/share/java/mysql-connector-java-${mysql_conn_var}.jar $HIVE_HOME/lib/mysql-connector-java.jar

ENTRYPOINT /conf/bootstrap.sh; bash
