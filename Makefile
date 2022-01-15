OMNIEDGE_VERSION="0.2.1"

.PHONY: omniedge-% clean purge

all: omniedge-arm64v8 omniedge-armv7

omniedge-%:
	@./build-package.sh ${OMNIEDGE_VERSION} $*

clean:
	rm -rf _build _omniedge

purge: clean
	rm -rf spks

