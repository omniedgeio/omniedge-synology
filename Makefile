OMNIEDGE_VERSION="0.2.1"

.PHONY: omniedge-% clean purge

all: omniedgecli-ubuntu-18.04 omniedgecli-armv7 omniedgecli-arm64v8

omniedge-%:
	@./build-package.sh ${OMNIEDGE_VERSION} $*

clean:
	rm -rf _build _omniedge

purge: clean
	rm -rf spks

