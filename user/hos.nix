{ pkgs, ... }:

{
  imports =
  [ ./vim.nix
    # ./shell.nix
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "hos" = {
      # shell = pkgs.zsh;
      isNormalUser = true;
      description = "hos";
      # initialPassword = "nixos";
      extraGroups = [ "networkmanager" "wheel" "kvm" "docker" "adbusers" ];
      packages = with pkgs;
      [ xclip
        # gitmux
        # thunderbird
        xterm
        tabbed
        simp1e-cursors
        papirus-icon-theme
        tree-sitter
        # comixcursors
        catimg
        fastfetch
        screen
        hugo
      ];
    };
  };
}
