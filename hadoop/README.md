# docker-Hadoop-Pseudo-Distributed

For building docker image, first download hadoop-2.8.4.tar.gz file from one of the mirrow sites via http://www.apache.org/dyn/closer.cgi/hadoop/common/ and untar to the same directory, then run:

```bash
docker build -t hadoop-pdm .
```

For launching hadoop in pseudo-distributed mode, run:

```bash
docker run -it \
	-p 8088:8088 \
	-p 19888:19888 \
	-p 50070:50070 \
	--name hadoop-cluster \
	--mount type=bind,source="$(pwd)"/../examples,target=/home/hadoop/examples \
	hadoop-pdm
```

To resolve container name conflict error, run the follow command before launching the cluster:
```bash
docker ps -aq --no-trunc -f status=exited | xargs docker rm
```
