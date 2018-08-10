#!/bin/bash

if ! $(hadoop fs -test -d students.csv) ; then
    echo "Adding input file(s) to hdfs"
    hadoop fs -put ../data/students.csv;
fi

echo "Testing Pig with MapReduce"
pig -x mapreduce script.pig

echo "Testing Pig with Tez"
pig -x tez script.pig
