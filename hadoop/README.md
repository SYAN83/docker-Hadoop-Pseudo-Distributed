# Hadoop core (pseudo-distributed mode)

## Verson:
  - Ubuntu: 16.04
  - Python: 3.5.5
  - Hadoop: 2.8.4

## Build:

- Download Packages into `hadoop` directory:
  
- Build docker image (image name: hadoop-pdm):

  ```bash
  docker build -t hadoop-pdm .
  ```
## Launch
  - Launch Hadoop in pseudo-distributed mode:

  ```bash
  docker run -it \
    -p 8088:8088 \
    -p 19888:19888 \
    -p 50070:50070 \
    --name hadoop-cluster \
    --mount type=bind,source="$(pwd)"/../examples,target=/home/hadoop/examples \
    hadoop-pdm
  ```

## Toubleshooting

  To resolve container name conflict error, run the follow command before launching the cluster:
  
  ```bash
  docker ps -aq --no-trunc -f status=exited | xargs docker rm
  ```
