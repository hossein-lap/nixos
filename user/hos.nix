{ pkgs, ... }:

{
  imports =
  [ ./vim.nix
    # ./shell.nix
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "hos" = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "hos";
      # initialPassword = "nixos";
      extraGroups = [ "networkmanager" "wheel" "kvm" "docker" ];
      packages = with pkgs;
      [ xclip
        # gitmux
        # thunderbird
        xterm
        tabbed
        steam
        telegram-desktop
        discord
        # vscodium
        simp1e-cursors
        papirus-icon-theme
        tree-sitter
        # comixcursors
        emacs
        kitty
        # obs-studio
        catimg
        fastfetch
        google-chrome
        lf
        # screen
      ];
    };
  };
}
