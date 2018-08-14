CREATE DATABASE IF NOT EXISTS test;

DROP TABLE IF EXISTS test.students;

CREATE TABLE test.students (
  sid INT,
  name STRING,
  age INT,
  gender STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

LOAD DATA INPATH 'students.csv' OVERWRITE INTO TABLE test.students;

SELECT * FROM test.students;

SELECT gender, COUNT(*), AVG(age) FROM test.students GROUP BY gender;
