# docker-Hadoop-Pseudo-Distributed

For building docker image, run:

```bash
docker build -t hadoop-pdm .
```

For launching hadoop in pseudo-distributed mode, run:

```bash
docker run -it \
	-p 8088:8088 \
	-p 19888:19888 \
	-p 50030:50030 \
	-p 50070:50070 \
	--name hadoop-cluster \
	--mount type=bind,source="$(pwd)"/examples,target=/home/hadoop/examples \
	hadoop-pdm
```

To resolve container name conflict, run:
```bash
docker ps -aq --no-trunc -f status=exited | xargs docker rm
```
