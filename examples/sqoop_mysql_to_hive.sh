sqoop import \
&& --connect jdbc:mysql://localhost:3306/employees?zeroDateTimeBehavior=CONVERT_TO_NULL \
&& --username hadoop \
&& --table departments 
&& -m 1 \
&& --hive-import