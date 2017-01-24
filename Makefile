SERVICE_NAME=node-oracle
VERSION=$(shell git rev-parse --short HEAD)

all: build

version:
	echo $(VERSION) > VERSION

build: version build-image

build-image:
	docker build -t $(SERVICE_NAME):latest .
	docker tag $(SERVICE_NAME):latest \
		$(SERVICE_NAME):$(VERSION)
	-docker ps -qaf status=exited | xargs docker rm
	-docker images -qaf dangling=true | xargs docker rmi
	docker images | grep $(SERVICE_NAME)
