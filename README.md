## PHP CLI dockerfile
This repository contains **Dockerfile** of PHP CLI Docker's [automated build](https://hub.docker.com/r/xaamin/php-cli)

### Base docker image
* [xaamin/ubuntu](https://registry.hub.docker.com/r/xaamin/ubuntu)

### Installation
* Install [Docker](https://www.docker.com)
* Download automated build from [Docker Hub](https://hub.docker.com/r/xaamin/php) `docker pull xaamin/php-cli:8.1`

### Usage
```
	docker run --rm -it xaamin/php-cli:8.1 bash
```