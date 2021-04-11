.PHONY: omniedge-% clean purge

all: omniedge-amd64

omniedge-%:
	@./build-package.sh $*

clean:
	rm -rf _build _omniedge

purge: clean
	rm -rf spks

