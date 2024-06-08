{ config, pkgs, ... }:
{
  # tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
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
  
}
