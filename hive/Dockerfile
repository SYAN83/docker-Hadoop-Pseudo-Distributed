# Apache Hive 
#
# VERSION:
#	Tez:	0.9.1
#	Hive:	2.3.3

FROM hadoop-pdm

LABEL maintainer="Shu Yan <yanshu.usc@gmail.com>"
LABEL description="This image sets up a hive cluster"

USER hadoop

# COPY apache-tez-0.9.1-bin /usr/local/apache-tez-0.9.1-bin
# RUN sudo ln -s /usr/local/apache-tez-0.9.1-bin /usr/local/tez


# Install maven
RUN sudo apt update && \
	sudo apt -y install maven autoconf libtool

COPY protobuf-2.5.0 /home/hadoop/protobuf-2.5.0

RUN sudo chown -R hadoop:hadoop /home/hadoop/protobuf-2.5.0 \
	&& cd /home/hadoop/protobuf-2.5.0 \
	&& chmod +x autogen.sh && ./autogen.sh \
	&& chmod +x configure && ./configure --prefix=/usr \
	&& make && sudo make install \
	&& rm -r /home/hadoop/protobuf-2.5.0

COPY apache-tez-0.9.1-src /usr/local/apache-tez-0.9.1-src
COPY configs/ /tmp/

ENV TEZ_CONF_DIR=$HADOOP_CONF_DIR
ENV TEZ_JARS=/usr/local/tez
ENV HADOOP_CLASSPATH=${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*

RUN sudo chown -R hadoop:hadoop /usr/local/apache-tez-0.9.1-src \
	&& sudo ln -s /usr/local/apache-tez-0.9.1-src /usr/local/tez \
	&& mv /tmp/pom.xml /usr/local/tez/pom.xml \
	&& mv /tmp/tez-site.xml $TEZ_CONF_DIR/tez-site.xml \
	&& mv /tmp/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml \
	&& cd /usr/local/tez \
	&& mvn clean install -DskipTests=true -Dmaven.javadoc.skip=true \
	&& tar xzvf tez-dist/target/tez-0.9.1-minimal.tar.gz -C $TEZ_JARS

RUN sudo chown hadoop:hadoop /tmp/bootstrap.sh \ 
	&& chmod +x /tmp/bootstrap.sh
	
ENTRYPOINT /tmp/bootstrap.sh; bash



# COPY apache-maven-3.5.4 /usr/local/apache-maven-3.5.4
# RUN sudo chown -R hadoop:hadoop /usr/local/apache-maven-3.5.4
# RUN sudo ln -s /usr/local/apache-maven-3.5.4 /usr/local/maven

# ENV PATH=$PATH:/usr/local/maven/bin

# Install Hive
# RUN echo 'Install Hive'
# COPY apache-hive-2.3.3-bin /usr/local/apache-hive-2.3.3-bin
# RUN sudo chown -R hadoop:hadoop /usr/local/apache-hive-2.3.3-bin
# RUN sudo ln -s /usr/local/apache-hive-2.3.3-bin /usr/local/hive

# Hive env variables
# ENV HIVE_HOME=/usr/local/hive
# ENV PATH=$PATH:$HIVE_HOME/bin
