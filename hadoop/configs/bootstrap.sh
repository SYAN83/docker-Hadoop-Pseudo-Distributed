#!/bin/bash

$HADOOP_CONF_DIR/hadoop-env.sh
# sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

sudo /etc/init.d/ssh start

# start hdfs
$HADOOP_HOME/sbin/start-dfs.sh
# create HDFS directory
$HADOOP_HOME/bin/hdfs dfs -mkdir /user \
&& $HADOOP_HOME/bin/hdfs dfs -mkdir /user/hadoop \
&& $HADOOP_HOME/bin/hdfs dfs -chown hadoop:hadoop /user/hadoop
# start yarn
$HADOOP_HOME/sbin/start-yarn.sh
# start historyserver
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver