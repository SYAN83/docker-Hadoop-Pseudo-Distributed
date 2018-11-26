# Linux Toolkits

## Verson:
  - Ubuntu: 16.04
  - Python: 3.5.2
  - MySQL: 5.7.23

## Build image (docker image name: linux-toolkits):

  ```bash
  docker build -t linux-toolkits .
  ```
  
  - Image also available on Docker Hub as: [syan83/linux-toolkits](https://hub.docker.com/r/syan83/linux-toolkits/)
  
## Launch container:
  
- Launch container with bind mount and port forwarding:
  
  ```bash
  docker run -it \
    -p 8888:8888 \
    -p 3306:3306 \
    --mount type=bind,source="$(pwd)",target=/home/ubuntu/Workspace \
    linux-toolkits
  ```
  
- Note: Replace image name `linux-toolkits` with `syan83/linux-toolkits` if you're pulling the image from Docker Hub.

## Toubleshooting

  To remove all the stopped containers, run:
  
  ```bash
  docker ps -aq --no-trunc -f status=exited | xargs docker rm
  ```
