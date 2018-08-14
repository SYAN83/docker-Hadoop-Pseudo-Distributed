# TEZ/Hive/Pig

This docker image is based on `hadoop-pdm`, so make sure you have built or pulled `hadoop-pdm`.

## Required tar files:


To build:

```bash
docker build -t hive-pdm .
```

For launching hadoop in pseudo-distributed mode, run:

```bash
docker run -it \
	-p 8088:8088 \
	-p 19888:19888 \
	-p 50070:50070 \
	--name hadoop-cluster \
	--mount type=bind,source="$(pwd)"/../examples,target=/home/hadoop/examples \
	hive-pdm
```

To resolve container name conflict error, run the follow command before launching the cluster:

```bash
docker ps -aq --no-trunc -f status=exited | xargs docker rm
```

## Issues:
  tez UI is not working properly.
