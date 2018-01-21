IMAGE_NAME ?= quay.io/bshelton229/tectonic-etcd-snapshot
IMAGE_TAG ?= latest
IMAGE = $(IMAGE_NAME):$(IMAGE_TAG)

build:
	docker build -t $(IMAGE) .

push: build
	docker push $(IMAGE)
