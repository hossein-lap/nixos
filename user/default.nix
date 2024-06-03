{ config, ... }:
{
    import = [
        ./vim.nix
        ./home.nix
        # ./shell.nix # FIXME: arguments are broken
        ./users.nix
    ];
}
