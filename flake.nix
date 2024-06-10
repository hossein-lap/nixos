{
    description = "Hos's nixos config";
    inputs = {
        # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05";
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = {self, nixpkgs, nixos-hardware, home-manager, ...}@inputs: let
        inherit (self) outputs;
        # Supported systems for your flake packages, shell, etc.
        systems = [
          # "aarch64-linux"
          # "i686-linux"
          "x86_64-linux"
          # "aarch64-darwin"
          # "x86_64-darwin"
        ];
        # This is a function that generates an attribute by calling a function you
        # pass to it, with each system as an argument
        forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
        # For `nix run .` later
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

        nixosConfigurations = {
            # FIXME replace with your hostname
            nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                modules = [
                    # > Our main nixos configuration file <
                    ./configuration.nix
                ];
            };
        };

        homeConfigurations = {
            "hos" = home-manager.lib.homeManagerConfiguration {
                # Note: I am sure this could be done better with flake-utils or something
                # pkgs = import nixpkgs { system = "x86_64-linux"; };
                pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
                extraSpecialArgs = {inherit inputs outputs;};

                modules = [
                    # Defined later
                    ./home/default.nix
                ];
            };
        };
    };
}
