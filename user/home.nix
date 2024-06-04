{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
      username = "hos";
      homeDirectory = "/home/hos";

      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      stateVersion = "24.05"; # Please read the comment before changing.

      sessionVariables = {
        EDITOR = "nvim";
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
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hos/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # pass
  programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "/run/media/hos/hosusb/.password-store/";
        PASSWORD_STORE_KEY = "hosteam01@gmail.com";
        PASSWORD_STORE_CLIP_TIME = "120";
      };
  };

  # tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
    # shell = "${pkgs.mksh}/bin/mksh";
    baseIndex = 1;
    terminal = "screen-256color";

    # plugins = with pkgs; [
    #     {
    #         plugin = tmuxPlugins.resurrect;
    #         extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    #     }
    #     {
    #         plugin = tmuxPlugins.continuum;
    #         extraConfig = ''
    #             set -g @continuum-restore 'on'
    #             set -g @continuum-save-interval '60' # minutes
    #         '';
    #     }
    # ]

    extraConfig = '' # used for less common options, intelligently combines if defined in multiple places.
      BORDFG="blue"
      BORDBG="black"
      SEP1FG="#777777"
      SEP2FG="#777777"
      SEP1BG=$BORDBG
      SEP2BG="default"
      set -g status-style fg=$BORDFG,bg=$BORDBG
      set-window-option -g clock-mode-colour yellow
      set-option -g status-style bg=$SEP1BG,fg=$SEP1FG
      set-window-option -g window-status-style bg=$BORDBG,fg=$BORDFG
      set-window-option -g window-status-current-style bg=white,fg=black,dim
      set-window-option -g window-status-separator ""
      set-window-option -g window-status-style bg=$BORDBG,fg=$BORDFG
      set-window-option -g window-status-current-style bg=$BORDBG,fg=$BORDFG,bold
      set -g pane-border-style fg=$BORDFG,bg=$BORDBG
      set -g pane-active-border-style fg=$BORDFG,bg=$BORDBG
      set -g status-left-length 50
      set -g status-left "[#{session_name}]"
      set -g status-left-style fg=$BORDFG,bg=$BORDBG
      set -g window-status-separator ""
      setw -g window-status-format " #I:#W"
      setw -g window-status-current-format " #I:#W"
      set -g status-right-length 90
      set -g status-right "#(gitmux -cfg ~/.config/gitmux/config.yml \"#{pane_current_path}\")\"#{s|$HOME|~|;s|.*/||:pane_current_path}\" %y-%m-%d %H:%M"
      set -g status-right-style fg=$BORDFG,bg=$BORDBG
      set-option -g pane-border-style fg=default,bg=default,dim
      set-option -g pane-active-border-style fg=$BORDFG,bg=default
      set-option -g display-panes-active-colour blue
      set-option -g display-panes-colour brightred
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux.conf"
      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      bind -r ^ last-window # alter window
      bind -r k select-pane -U # switch to panel Up
      bind -r j select-pane -D # switch to panel Down 
      bind -r h select-pane -L # switch to panel Left
      bind -r l select-pane -R # switch to panel Right
      unbind v
      bind v command-prompt "rename-window '%%'"
      set -g status-keys vi
    '';
  };
  
  # bash
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

  programs.vim = {
      enable = true;
      extraConfig = ''
          set nu rnu
          set nocp
          set showmode showcmd showmatch
          set autoindent smartindent cindent
          set bs=2 ls=2
          set hlsearch incsearch
          set scrolloff=8
          nnoremap Q <nop>
          syntax on
          set background=dark
          " set t_Co=256
          " colorscheme lunaperche
          " colorscheme torte
          colorscheme slate
          set wildmenu wildmode=full
          set foldmethod=marker
          set splitbelow splitright
          set tabstop=4 shiftwidth=4
          au FileType yaml expandtab tabstop=2 shiftwidth=2
          set colorcolumn=80
          set undofile undodir=$HOME/.vim/undo undolevels=1000 undoreload=10000
          nnoremap <silent> ]t :tabnext<CR>
          nnoremap <silent> [t :tabprev<CR>
          nnoremap <silent> ]b :bnext<CR>
          nnoremap <silent> [b :bprev<CR>
          hi! Normal ctermbg=NONE guibg=NONE
          " hi! StatusLine ctermbg=232 guibg='#080808' ctermfg=darkblue guifg=darkblue
          set showtabline=2
      '';
  };

}
