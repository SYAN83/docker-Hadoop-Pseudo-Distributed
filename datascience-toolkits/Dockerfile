# Linux
#
# VERSION:
# 	Ubuntu: 16.04
#	Java:	1.8
#	Python:	3.5.5

FROM syan83/linux-toolkits

LABEL maintainer="Shu Yan <yanshu.usc@gmail.com>"
LABEL description="This image sets up a Linux Environment for testing purpose"

USER root

# Copy configs to Docker
COPY configs/ /conf/

# Install R
RUN apt-get -y install r-base
# RUN apt-get -y install libzmq3-dev libcurl-openssl1.0-dev libssl-dev
RUN Rscript /conf/installation.R


USER ubuntu
WORKDIR /home/ubuntu

ENTRYPOINT /conf/bootstrap.sh; bash
