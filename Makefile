IMAGE_NAME="scanpy-image"

all: image

image:
	docker build -f Dockerfile -t $(IMAGE_NAME) .

publish: image
	docker push $(IMAGE_NAME)

prune:
	docker container prune -f
	docker image prune -f

.PHONY: image publish prune
