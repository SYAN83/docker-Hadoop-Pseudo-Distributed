#!/bin/bash

# start SSH
sudo /etc/init.d/ssh start
# start mysql
sudo chown -R mysql:mysql /var/lib/mysql
sudo sed -i "/bind-address/c\bind-address            = 0.0.0.0" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo /etc/init.d/mysql start
# mysql create ubuntu user
echo "Creating MySQL USER ubuntu"
mysql -uroot -e "CREATE DATABASE ubuntu;
CREATE USER 'ubuntu'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'localhost' WITH GRANT OPTION;
CREATE USER 'ubuntu'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

echo "Creating MySQL Database movies_db"
mysql -uubuntu -e "CREATE DATABASE movies_db;"
echo "Loading tables"
mysql movies_db < /conf/movies_load.sql

# Config Jupyter notebook server
jupyter notebook --generate-config
sed -i "/c.NotebookApp.ip/c\c.NotebookApp.ip = '*'" /home/ubuntu/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.open_browser/c\c.NotebookApp.open_browser = False" /home/ubuntu/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.token/c\c.NotebookApp.token = u''" /home/ubuntu/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.allow_remote_access/c\c.NotebookApp.allow_remote_access = True" /home/ubuntu/.jupyter/jupyter_notebook_config.py
# Welcome screen
echo
figlet -f slant MySQL Server
echo
cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d \" -f2
python3 --version
mysql --version
mysql -e "SHOW TABLES FROM movies_db;"
echo
