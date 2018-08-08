#!/bin/bash
if ! $(hadoop fs -test -d wordcount/input) ; then
    echo "Adding input file(s) to hdfs"
    hadoop fs -put input/ wordcount/input;
fi

if $(hadoop fs -test -d wordcount/output) ; then
    echo "Removing output directory from hdfs"
    hadoop fs -rm -r wordcount/output
fi

# Compile WordCount.java and create a jar:
hadoop com.sun.tools.javac.Main WordCount.java
jar cf wc.jar WordCount*.class

# Run the application:
hadoop jar wc.jar WordCount wordcount/input wordcount/output
