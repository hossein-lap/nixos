{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "hos";
    home.homeDirectory = "/home/hos";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.11"; # Please read the comment before changing.

    nixpkgs.config.allowUnfree = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [

        # # terminal
        # kitty kitty-themes kitty-img kitti3

        # remote control
        anydesk x11vnc krdc

        # games
        xonotic nudoku

        # ide
        codeblocks vscode
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #     echo "Hello, ${config.home.username}!"
        # '')
    ];

    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            # ms-pyright.pyright
            # ms-python.pylint
            # ms-python.python
            # ms-python.vscode-pylance
            # scala-lang.scala
            # yzhang.markdown-all-in-one

            vscodevim.vim

            # zhuangtongfa.material-theme
            # thorerik.hacker-theme
            # dracula-theme.theme-dracula
            # sainnhe.gruvbox-material
            # teabyii.ayu
            #
            # ms-vscode.makefile-tools
            # twxs.cmake
            # sumneko.lua
            # xaver.clang-format
            # ms-vscode.cpptools-extension-pack

        ];
    };

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        ".mkshrc".source = ./dotfiles/mkshrc;
        ".zshrc".source = ./dotfiles/zshrc;
        ".screenrc".source = ./dotfiles/screenrc;
        ".Xresources".source = ./dotfiles/Xresources;
        ".xprofile".source = ./dotfiles/xprofile;
    };

    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        PDFVIEWER_texdoc = "zathura";
        XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
        XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";

    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #    ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #    ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #    /etc/profiles/per-user/hos/etc/profile.d/hm-session-vars.sh
    #

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
