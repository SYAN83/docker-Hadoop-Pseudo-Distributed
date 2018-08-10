
# Hadoop core (pseudo-distributed mode)

## Verson:
  - Ubuntu: 16.04
  - Python: 3.5.5
  - Hadoop: 2.8.4

## Build Hadoop docker image:

- Download hadoop release (version 2.8.4) tarball and untar into `hadoop` directory:

  ```bash
  cd hadoop
  wget http://apache.osuosl.org/hadoop/common/hadoop-2.8.4/hadoop-2.8.4.tar.gz
  tar -xzvf hadoop-2.8.4.tar.gz
  ```
  
- Build docker image (docker image name: hadoop-core):

  ```bash
  docker build -t hadoop-core .
  ```
  
## Launch Hadoop cluster:

  - Launch Hadoop in pseudo-distributed mode:

  ```bash
  docker run -it \
    -p 8088:8088 \
    -p 19888:19888 \
    -p 50070:50070 \
    --name hadoop-cluster \
    --mount type=bind,source="$(pwd)"/../examples,target=/home/hadoop/examples \
    hadoop-core
  ```

## Toubleshooting

  To resolve container name conflict error, run the follow command before launching the cluster:
  
  ```bash
  docker ps -aq --no-trunc -f status=exited | xargs docker rm
  ```
