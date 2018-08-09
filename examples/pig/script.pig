
A = LOAD 'students.csv' USING PigStorage(',') AS (id:int, name:chararray, age:int, gender:chararray);
by_age = GROUP A BY age;
count_age = FOREACH by_age GENERATE group as age, COUNT(A);
DUMP count_age;
