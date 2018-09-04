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
	&& apt -y install openjdk-8-jdk openssh-client openssh-server rsync sudo vim git python python-pip python3 python3-pip \
	&& apt -y install figlet

# install jupyter
RUN pip3 install --upgrade pip
RUN pip3 install jupyter

# Install Mysql
RUN sudo apt update \
	&& sudo DEBIAN_FRONTEND=noninteractive apt -y install mysql-server \
	&& sudo usermod -d /var/lib/mysql/ mysql
# 	&& echo 'validate_password_policy=LOW' >> /etc/mysql/my.cnf

# Copy configs to Docker
COPY configs/ /conf/

# Create ubuntu user
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu

# Jupyter notebook Port
EXPOSE 8888

ENTRYPOINT /conf/bootstrap.sh; bash
