#!/bin/bash

if ! $(hadoop fs -test -d students.csv) ; then
    echo "Adding input file(s) to hdfs"
    hadoop fs -put ../data/students.csv;
fi

pig -x mapreduce script.pig
