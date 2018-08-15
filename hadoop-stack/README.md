# TEZ/Hive/Pig

This docker image is based on `hadoop-core`, please make sure you have built or pulled `hadoop-core` before builing the image.

## Required tar files:


To build:

```bash
docker build -t hadoop-stack .
```

For launching hadoop-stack in pseudo-distributed mode, run:

```bash
docker run -it \
	-p 8088:8088 \
	-p 19888:19888 \
	-p 50070:50070 \
	--name hadoop-stack \
	--mount type=bind,source="$(pwd)"/../examples,target=/home/hadoop/examples \
	hadoop-stack
```

To resolve container name conflict error, run the follow command before launching the cluster:

```bash
docker ps -aq --no-trunc -f status=exited | xargs docker rm
```

## Issues:
  tez UI is not working properly.
