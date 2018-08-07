#!/bin/bash

sudo /etc/init.d/ssh start

# start hdfs
$HADOOP_HOME/sbin/start-dfs.sh
# create HDFS directory
$HADOOP_HOME/bin/hdfs dfs -mkdir /user && $HADOOP_HOME/bin/hdfs dfs -mkdir /user/hadoop
# start yarn
$HADOOP_HOME/sbin/start-yarn.sh