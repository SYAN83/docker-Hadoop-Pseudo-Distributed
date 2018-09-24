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
# Config Jupyter notebook server
jupyter notebook --generate-config
sed -i "/c.NotebookApp.ip/c\c.NotebookApp.ip = '*'" /home/hadoop/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.open_browser/c\c.NotebookApp.open_browser = False" /home/hadoop/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.token/c\c.NotebookApp.token = u''" /home/hadoop/.jupyter/jupyter_notebook_config.py
# welcome screen
echo
figlet -f slant Hadoop Core
echo 
cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d \" -f2
python3 --version
hadoop version | head -n 1
echo