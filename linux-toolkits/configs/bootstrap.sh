#!/bin/bash

# start SSH
sudo /etc/init.d/ssh start
# start mysql
sudo chown -R mysql:mysql /var/lib/mysql
sudo /etc/init.d/mysql start
# mysql create hadoop user
echo "Creating MySQL Database"
mysql -uroot -e "CREATE DATABASE ubuntu;
CREATE USER 'ubuntu'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'ubuntu'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;"
# Config Jupyter notebook server
jupyter notebook --generate-config
sed -i "/c.NotebookApp.ip/c\c.NotebookApp.ip = '*'" /home/ubuntu/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.open_browser/c\c.NotebookApp.open_browser = False" /home/ubuntu/.jupyter/jupyter_notebook_config.py
# Welcome screen
echo
figlet -f slant Linux Toolkits
echo
