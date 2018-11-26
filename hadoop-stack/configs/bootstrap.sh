#!/bin/bash

$HADOOP_CONF_DIR/hadoop-env.sh

# start SSH
sudo /etc/init.d/ssh start
# start mysql
sudo chown -R mysql:mysql /var/lib/mysql
sudo /etc/init.d/mysql start
# mysql create hive user
mysql -uroot -e "CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive_passwd';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'localhost';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost';
FLUSH PRIVILEGES;"
# create hive initial database schema
schematool -dbType mysql -initSchema 2>/dev/null
# start hive metastore
# hive --service metastore &

# mysql create hadoop user
mysql -uroot -e "CREATE DATABASE hadoop;
CREATE USER 'hadoop'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'hadoop'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

tez_ver=tez-0.9.1

# start hdfs
$HADOOP_HOME/sbin/start-dfs.sh 2>/dev/null
# create HDFS directory
$HADOOP_HOME/bin/hdfs dfs -mkdir /user 2>/dev/null \
	&& $HADOOP_HOME/bin/hdfs dfs -mkdir /user/hadoop 2>/dev/null \
	&& $HADOOP_HOME/bin/hdfs dfs -chown hadoop:hadoop /user/hadoop 2>/dev/null \
	&& $HADOOP_HOME/bin/hdfs dfs -mkdir -p /apps/${tez_ver} 2>/dev/null \
	&& $HADOOP_HOME/bin/hdfs dfs -copyFromLocal /usr/local/tez/tez-dist/target/${tez_ver}.tar.gz /apps/${tez_ver}/ 2>/dev/null \
	&& $HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hive/warehouse 2>/dev/null \
	&& $HADOOP_HOME/bin/hdfs dfs -chown -R hadoop:hadoop /user/hive/ 2>/dev/null \
	&& $HADOOP_HOME/bin/hdfs dfs -chmod g+w /user/hive/warehouse 2>/dev/null

# start yarn
$HADOOP_HOME/sbin/start-yarn.sh 2>/dev/null
# start historyserver
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver 2>/dev/null

# $HADOOP_HOME/bin/hdfs dfsadmin -safemode leave \
echo
figlet -f slant Hadoop Stack
echo 
cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d \" -f2
python3 --version
mysql --version
hadoop version | head -n 1
hive --version | head -n 1
pig --version 2>/dev/null | head -n 1
echo