{
    description = "Hos's nixos config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # inputs.nixvim = {
        #     url = "github:nix-community/nixvim/nixos-24.05";
        #     # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };

    };

    outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
        let
            system = "x86_64-linux";
            myhostname = "nixos";
        in {
        nixosConfigurations.${myhostname} = nixpkgs.lib.nixosSystem {
            inherit system;

            modules = [
                nixos-hardware.nixosModules.asus-fx506hm
                ./configuration.nix
                ./hardware/default.nix
                ./user/default.nix
                ./gui/default.nix
            ];
        };

        homeConfigurations.hos = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            modules = [
                ./user/home.nix
            ];
        };
    };
}
