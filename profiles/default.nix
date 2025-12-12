{ pkgs, config, ... }:
{
    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone
    time.timeZone = "Asia/Tehran";

    # Select internationalisation properties
    i18n.defaultLocale = "en_US.UTF-8";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.localBinInPath = true;
    # list packages installed in system profile. to search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      vim-full tmux fzf git mg bc screen btop unzip pciutils moreutils
      tree-sitter unrar links2 tree jcal ncdu lsof nmap lf nnn entr
      linux-manual man-pages man-pages-posix pass pwgen stow antigen
      julia-lts go gcc ruby lua54Packages.lua nodejs_22 python3 groovy pipx
      docker docker-buildx docker-compose distrobox qemu qemu_kvm qemu-user
      qemu-utils wget aria2 curl yt-dlp nfs-utils file tigervnc
    ];

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = false;
    };

    programs.proxychains = {
      enable = true;
      proxies = {
        prx1 = {
          enable = true;
          type = "socks5";
          host = "127.0.0.1";
          port = 20170;
        };
      };
    };

    programs.bash = {
        enable = true;
        completion.enable = true;
        promptInit = ''
            # Provide a nice prompt if the terminal supports it.
            if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
                PROMPT_COLOR="1;31m"
                ((UID)) && PROMPT_COLOR="1;32m"
                if [ -n "$INSIDE_EMACS" ]; then
                    # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
                    PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
                else
                    PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
                fi
                if test "$TERM" = "xterm"; then
                    PS1="\[\033]2;\h:\u:\w\007\]$PS1"
                fi
            fi
        '';
    };

    environment.shells = with pkgs; [ bash ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions
    programs.mtr.enable = true;
    # services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };

    # V2rayA
    services.v2raya = {
      enable = true;
    };

    # enable the openssh daemon
    services.openssh.enable = true;

    # Open ports in the firewall
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether
    # networking.firewall.enable = false;
}
