all:
	nix run . -- build --flake .

install:
	nix run . -- switch --flake .
