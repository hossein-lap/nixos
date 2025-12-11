SUDO = sudo
CC = nixos-rebuild
CARGS = -I nixos-config=./configuration.nix

COMMAND = $(SUDO) $(CC) $(CARGS)


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
