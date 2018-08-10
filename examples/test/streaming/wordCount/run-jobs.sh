#!/bin/bash
if ! $(hadoop fs -test -d wordcount) ; then
    echo "Creating wordcount directory"
    hadoop fs -mkdir wordcount
fi
if ! $(hadoop fs -test -d wordcount/input) ; then
    echo "Adding input file(s) to hdfs"
    hadoop fs -put ../../data/wordCount_input/ wordcount/input;
fi
if $(hadoop fs -test -d wordcount/output) ; then
    echo "Removing output directory from hdfs"
    hadoop fs -rm -r wordcount/output
fi

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.8.4.jar \
    -files mapper.py,reducer.py \
    -input wordcount/input \
    -output wordcount/output \
    -mapper mapper.py \
    -reducer reducer.py

