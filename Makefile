SUDO = sudo
CC = nixos-rebuild
CARGS = --include nixos-config=./configuration.nix

COMMAND = $(CC) $(CARGS)

all:
	echo Nothing to do

clean:
	nix-collect-garbage -d
	make switch

build:
	$(COMMAND) build

boot:
	$(COMMAND) boot

test:
	$(COMMAND) test

switch:
	$(COMMAND) switch

readme:
	asciidoctor README.adoc

upgrade:
	$(COMMAND) boot --upgrade
