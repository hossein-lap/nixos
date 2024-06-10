all:
	sudo nixos-rebuild switch --flake ./
	make manager
# 	nix run . -- switch --flake .

build:
	sudo nixos-rebuild build --flake ./
	home-manager build --flake ./
	# nix run -v . -- build --flake .

test:
	sudo nixos-rebuild test --flake ./
	home-manager test --flake ./
	# nixos-rebuild --flake .#"nixos"

manager:
	home-manager switch --flake ./
