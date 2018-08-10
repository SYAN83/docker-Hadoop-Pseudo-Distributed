#!/bin/bash
echo "Preparing data"
hdfs_dir="wordcount_test"
if ! $(hadoop fs -test -d $hdfs_dir) ; then
    echo "Creating $hdfs_dir directory"
    hadoop fs -mkdir $hdfs_dir
fi
if ! $(hadoop fs -test -d $hdfs_dir/input) ; then
    echo "Adding input file(s) to hdfs"
    hadoop fs -put -p input/ $hdfs_dir/input;
fi
if $(hadoop fs -test -d $hdfs_dir/output) ; then
    echo "Removing output directory from hdfs"
    hadoop fs -rm -r $hdfs_dir/output
fi
# Run Java MapReduce test:
echo "Testing Jave MapReduce"
# Compile WordCount.java and create a jar:
hadoop com.sun.tools.javac.Main WordCount.java
jar cf wc.jar WordCount*.class
# Run the application:
hadoop jar wc.jar WordCount $hdfs_dir/input $hdfs_dir/output
echo "Java mapReduce test sucess"

if $(hadoop fs -test -d $hdfs_dir/output) ; then
    echo "Removing output directory from hdfs"
    hadoop fs -rm -r $hdfs_dir/output
fi
# Run hadoop streaming test:
echo "Testing Hadoop streaming"
hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.8.4.jar \
    -files mapper.py,reducer.py \
    -input $hdfs_dir/input \
    -output $hdfs_dir/output \
    -mapper mapper.py \
    -reducer reducer.py
echo "Hadoop streaming test sucess"

