{ config, ... }:
{
    imports = [
        # ./vim.nix
        # ./shell.nix # FIXME: arguments are broken
        ./users.nix
    ];
}
