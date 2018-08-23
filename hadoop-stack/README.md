# Hadoop stack (pseudo-distributed mode)

This docker image is based on `syan83/hadoop-core`

## Verson:
  - Tez:  0.9.1
  - Hive: 2.3.3
  - Pig:  0.17.0
  
## Build Hadoop docker image:

- Download tez/hive/pig/protobuf/zookeeper tarball and untar into `hadoop-stack` directory:

  ```bash
  [TODO]
  ```
  
- Build docker image (docker image name: hadoop-core):

  ```bash
  docker build -t hadoop-stack .
  ```
  
## Launch Hadoop cluster:

- Launch Hadoop in pseudo-distributed mode:
  
  ```bash
  docker run -it hadoop-stack
  ```
  
- Launch Hadoop with bind mount and port forwarding:
  
  ```bash
  cd examples/
  docker run -it \
    -p 8088:8088 \
    -p 19888:19888 \
    -p 50070:50070 \
    --name hadoop-stack \
    --mount type=bind,source="$(pwd)",target=/home/hadoop/examples \
    hadoop-stack
  ```
  
- Note: Replace image name `hadoop-stack` with `syan83/hadoop-stack:latest` if you're pulling the image from [Docker Hub](https://hub.docker.com/r/syan83/hadoop-stack/)
