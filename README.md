## PHP dockerfile
This repository contains **Dockerfile** of PHP5 Docker's [automated build](https://hub.docker.com/r/xaamin/php)

### Base docker image
* [xaamin/ubuntu](https://registry.hub.docker.com/r/xaamin/ubuntu)

### Installation
* Install [Docker](https://www.docker.com)
* Download automated build from [Docker Hub](https://hub.docker.com/r/xaamin/php) `docker pull xaamin/php`

### Manual build
* Build an image from Dockerfile `docker build -t xaamin/php https://github.com/xaamin/php.git`

### Usage
```
	docker run --rm -it xaamin/php
```