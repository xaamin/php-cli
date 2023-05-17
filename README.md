## PHP CLI dockerfile
This repository contains **Dockerfile** of PHP CLI Docker's [automated build](https://hub.docker.com/r/xaamin/php-cli)

The following versions are published to docker hub:

* 5.6
* 7.0
* 7.1
* 7.2
* 7.3
* 7.4
* 8.0
* 8.1
* 8.2

### Base docker image
* [xaamin/ubuntu](https://registry.hub.docker.com/r/xaamin/ubuntu)

### Installation
* Install [Docker](https://www.docker.com)
* Download automated build from [Docker Hub](https://hub.docker.com/r/xaamin/php) `docker pull xaamin/php-cli:8.2`

### Usage

```bash
docker run --rm -it xaamin/php-cli:8.2 bash
```

### Custom builds

Edit the `.env` file and then execute the command

```bash
bash ./build.sh
```