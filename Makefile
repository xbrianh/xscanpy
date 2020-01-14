include common.mk

all: image

image:
	docker build -f ${XSCANPY_HOME}/Dockerfile \
	--build-arg XSCANPY_USER \
	-t $(XSCANPY_IMAGE_NAME) .

publish: image
	docker push $(XSCANPY_IMAGE_NAME)

prune:
	docker container prune -f
	docker image prune -f

.PHONY: image publish prune
