all:
	nixos-rebuild test --flake . --show-trace
install:
	nixos-rebuild switch --flake . --show-trace
