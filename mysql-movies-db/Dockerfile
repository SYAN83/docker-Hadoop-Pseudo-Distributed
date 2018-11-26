# Linux
#
# VERSION:
# 	Ubuntu: 16.04
#	Java:	1.8
#	Python:	3.5.2

FROM syan83/linux-toolkits:latest

LABEL maintainer="Shu Yan <yanshu.usc@gmail.com>"
LABEL description="MySQL movies_db"

# Copy configs to Docker image
COPY configs/ /conf/

ENTRYPOINT /conf/bootstrap.sh; bash
