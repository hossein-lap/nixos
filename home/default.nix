{pkgs, config, ...}:

{
  imports =
  [ ./tmux.nix
    ./vim.nix
    ./shell.nix
    ./pass.nix
    ./game.nix
  ];
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home.username = "hos";
  home.homeDirectory = "/home/hos";
  home.packages = with pkgs; [
    # nixpkgs-fmt
    cowsay
    lolcat
    lowdown
    # obs-studio
    telegram-desktop
    discord
    # vscodium
    emacs
    kitty
    google-chrome
    lf
  ];
  home.file =
  { ".mkshrc".source = ../dotfiles/mkshrc;
    ".screenrc".source = ../dotfiles/screenrc;
    ".Xresources".source = ../dotfiles/Xresources;
  };
  home.sessionVariables =
  { EDITOR = "nvim";
    VISUAL = "nvim";
    PDFVIEWER_texdoc = "zathura";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    GOPATH = "${config.home.homeDirectory}/.local/share/golang";
    GOMODCACHE = "${config.home.homeDirectory}/.local/share/golang/mod";
    RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";
    CARGO_HOME = "${config.home.homeDirectory}/.local/share/cargo";
    NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/.config/npm/npmrc ";
    WINEPREFIX = "${config.home.homeDirectory}/.local/share/wine";
    WINEARCH = "win32";
    EXINIT = "${config.home.homeDirectory}/.config/ex/exrc";
    TASKRC = "${config.home.homeDirectory}/.config/task"; # task / taskwarrior
  };
  home.stateVersion = "24.05"; # To figure this out you can comment out the line and see what version it expected.
}
