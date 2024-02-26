.EXPORT_ALL_VARIABLES:

SHELL := /bin/bash
DIST := jammy

all: $(DIST)

jammy: clean
	DISTRO_NAME=ubuntu DISTRO_CODENAME=jammy DISTRO_VERSION=22.04 packer build .

clean:
	@$(foreach dir,$(DIST), \
	$(if $(wildcard ./dist/$(dir)), \
		echo "Deleting directory: ./dist/$(dir)" && rm -rf ./dist/$(dir), \
		echo "Directory not found: ./dist/$(dir)"))

.PHONY: all $(DIST) clean
