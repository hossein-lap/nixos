{ pkgs, config, ... }:
{
    # choose your desktop/window manager
    imports = [
        # ./plasma6.nix
        ./cinnamon.nix
        # ./budgie.nix
    ];
}
