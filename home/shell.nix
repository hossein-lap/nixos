{ config, pkgs, ... }:
{

    home.packages = [
        pkgs.tcsh
        pkgs.mksh
    ];

    programs.bash = {
        enable = true;
        bashrcExtra = ''
            # If not running interactively, don't do anything
            case $- in
                *i*) ;;
                *) return;;
            esac
            if [ -f ~/.bash_aliases ]; then
                . ~/.bash_aliases
            fi
            if ! shopt -oq posix; then
                if [ -f /usr/share/bash-completion/bash_completion ]; then
                    . /usr/share/bash-completion/bash_completion
                elif [ -f /etc/bash_completion ]; then
                    . /etc/bash_completion
                fi
            fi
            if [ -d ~/.config/shell/ ]; then
                source ~/.config/shell/bashrc
                source ~/.config/shell/env.sh
                source ~/.config/shell/aliases.sh
            fi
        '';
    };

    programs.zsh = {
        enable = true;
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "python" "man" "vi-mode" "docker" "docker-compose" ];
            theme = "robbyrussell";
        };
    };
}
