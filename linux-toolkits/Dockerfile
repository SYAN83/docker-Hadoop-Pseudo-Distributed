# Linux
#
# VERSION:
# 	Ubuntu: 16.04
#	Java:	1.8
#	Python:	3.5.5

FROM ubuntu:16.04

LABEL maintainer="Shu Yan <yanshu.usc@gmail.com>"
LABEL description="This image sets up a Linux Environment for testing purpose"

USER root

# update system
RUN	apt update \
	&& apt -y install openjdk-8-jdk openssh-client openssh-server rsync sudo vim git figlet python python-pip python3 python3-pip

# install jupyter
RUN pip3 install --upgrade pip
RUN pip3 install jupyter

# Install MySQL
RUN sudo apt update \
	&& sudo DEBIAN_FRONTEND=noninteractive apt -y install mysql-server \
	&& sudo usermod -d /var/lib/mysql/ mysql

# Install MySQL kernel
RUN pip install git+https://github.com/shemic/jupyter-mysql-kernel

# Copy configs to Docker image
COPY configs/ /conf/

# Create ubuntu user
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu

RUN mkdir -p /home/ubuntu/.local/config/
RUN cp /conf/mysql_config.json /home/ubuntu/.local/config/

# Jupyter notebook Port
EXPOSE 8888
EXPOSE 3306
EXPOSE 22

ENTRYPOINT /conf/bootstrap.sh; bash
