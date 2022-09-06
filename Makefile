OMNIEDGE_VERSION="0.2.4"

.PHONY: omniedge-% clean purge

all: omniedge-amd64 omniedge-arm64v8

omniedge-%:
	@./build-package.sh ${OMNIEDGE_VERSION} $*

clean:
	rm -rf _build _omniedge

purge: clean
	rm -rf spks

