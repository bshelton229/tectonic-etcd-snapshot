IMAGE_REPOSITORY ?= quay.io/bshelton229/tectonic-etcd-snapshot
IMAGE_TAG ?= dev
IMAGE = $(IMAGE_REPOSITORY):$(IMAGE_TAG)

build:
	docker build -t $(IMAGE) .

push: build
	docker push $(IMAGE)

shell: build
	docker run --rm -it $(IMAGE) bash
