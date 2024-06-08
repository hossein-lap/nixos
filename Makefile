all:
	nixos-rebuild build --flake ./
	# nix run -v . -- build --flake .

install:
	nixos-rebuild switch --flake ./
# 	nix run . -- switch --flake .

test:
	nixos-rebuild test --flake ./
	# nixos-rebuild --flake .#"nixos"
