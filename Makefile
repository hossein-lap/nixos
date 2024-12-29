FEAT = --extra-experimental-features nix-command --extra-experimental-features flakes

all:
	sudo nixos-rebuild switch --flake ./#primejade --show-trace
	make manager
# 	nix run . -- switch --flake .

build:
	sudo nixos-rebuild build --flake ./ --show-trace
	home-manager build --flake ./
	# nix run -v . -- build --flake .

test:
	sudo nixos-rebuild test --flake ./ --show-trace
	home-manager test --flake ./
	# nixos-rebuild --flake .#"nixos"

manager:
	home-manager switch --flake ./ --show-trace $(FEAT)
