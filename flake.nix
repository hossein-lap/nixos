{
    description = "Hos's nixos config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
        let
            system = "x86_64-linux";
        in {
                          # hostname: nixos
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            inherit system;

            modules = [
                nixos-hardware.nixosModules.asus-fx506hm
                ./vim.nix
                # ./shell.nix
                ./users.nix
                ./nvidia.nix
                ./plasma.nix
                ./configuration.nix
                ./hardware-configuration.nix
            ];
        };

        homeConfigurations.hos = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            modules = [
                ./home.nix
            ];
        };
    };
}
