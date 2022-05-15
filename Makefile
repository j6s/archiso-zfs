
build:
	mkdir -p out
	docker run \
		-v $(shell pwd)/build.sh:/build.sh \
		-v $(shell pwd)/out:/out \
		-e OUT_DIR=/out \
		--privileged \
		archlinux:base-devel \
		/build.sh
