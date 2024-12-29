# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            # ./battery.nix
            <nixos-hardware/asus/fx506hm>
            ./hardware-configuration.nix
            ./nvidia.nix
        ];

    nixpkgs.overlays =
        [ # myown build of `st` and `tabbed`
            (import ./overlay/st.nix)
            (import ./overlay/tabbed.nix)
        ];

    # Bootloader.
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        kernel = {
            enable = true;
            sysctl = {
                "vm.swappiness" = 10;
            };
        };
        # kernelParams = [
        #     "pcie_aspm=off"
        # ];
    };

    # # custom kernel
    # boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;

    # specialisation = {
    #     hardened.configuration = {
    #         system.nixos.tags = [ "hardened" ];
    #         # boot.kernelPackages = pkgs.linuxKernel.kernels.linux_hardened;
    #         boot.kernelPackages = pkgs.linuxKernel.packages.linux_hardened;
    #     };
    # };

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable network manager applet
    programs.nm-applet.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Tehran";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable the X11 windowing system.

    # Enable the MATE Desktop Environment.
    # services.xserver.desktopManager.mate.enable = true;
    services = {
        xserver = {
            enable = true;
            displayManager = {
                lightdm.enable = true;
                # defaultSession = "none+awesome";
                # defaultSession = "none+i3";
            };
            desktopManager.cinnamon.enable = true;
            windowManager.i3 = {
                enable = true;
                extraPackages = with pkgs; [
                    dmenu #application launcher most people use
                    # i3status # gives you the default i3 status bar
                    rofi
                    i3lock #default i3 screen locker
                    i3blocks #if you are planning on using i3blocks over i3status
                ];
            };
            dpi = 120;
            xkb = { # Configure keymap in X11
                variant = "";
                layout = "us,ir";
                options = "grp:alt_caps_toggle";
            };
        };
        cinnamon.apps.enable = true;
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    environment.variables = { EDITOR = "vim"; };

    # Config tmux
    programs.tmux = {
        enable = true;
        terminal = "screen-256color";
        baseIndex = 1;
        clock24 = true;
        extraConfig = ''
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
            set -g default-shell ${pkgs.zsh}/bin/zsh
            set -g status-left "[#{session_name}]"
            set -g status-left-style fg=$BORDFG,bg=$BORDBG
            set -g window-status-separator ""
            setw -g window-status-format " #I:#W"
            setw -g window-status-current-format " #I:#W"
            set -g status-right-length 90
            set -g status-right-style fg=$BORDFG,bg=$BORDBG
            set-option -g pane-border-style fg=default,bg=default,dim
            set-option -g pane-active-border-style fg=$BORDFG,bg=default
            set-option -g display-panes-active-colour blue
            set-option -g display-panes-colour brightred
            unbind v
            bind v command-prompt "rename-window '%%'"
            unbind r
            bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux.conf"
        '';
        withUtempter = true;
        keyMode = "vi";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.hos = {
        isNormalUser = true;
        description = "hos";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
        packages = with pkgs; [
            pulsemixer
            envsubst
            nsxiv
            kitty
            asciidoctor-with-extensions
            ruby
            simp1e-cursors
            lowdown
            pandoc
            emacs
            lolcat
            jcal
            figlet
            cowsay
            fortune
            xonotic
            google-chrome
            # ungoogled-chromium
            uget
            geany-with-vte
            vte
            guake
            rhythmbox
            telegram-desktop
            discord
            steam
            nekoray
            xterm
            tabbed
            st
            irssi
            screen
            hugo
            catimg
            tree-sitter
            fastfetch
            xclip
            audacity
            mpv
            # mpd
            # mpc
            yt-dlp
        ];
    };

    # Install vim
    programs.vim.defaultEditor = true;

    # # Install firefox.
    # programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Config bash
    programs.bash = {
        interactiveShellInit = ''
            test -f ~/.config/shell/bashrc  && source ~/.config/shell/bashrc
            test -f ~/.config/shell/env.sh  && source ~/.config/shell/env.sh
            test -f ~/.config/shell/aliases.sh  && source ~/.config/shell/aliases.sh
            test -f ~/.config/shell/binds.bash  && source ~/.config/shell/binds.bash
        '';
    };

    # Install zsh + OhMyZsh
    programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        autosuggestions.enable = true;
        interactiveShellInit = ''
            test -f ~/.config/shell/env.sh  && source ~/.config/shell/env.sh
            test -f ~/.config/shell/aliases.sh  && source ~/.config/shell/aliases.sh
            test -f ~/.config/shell/binds.zsh  && source ~/.config/shell/binds.zsh
        '';
        ohMyZsh = {
            enable = true;
            plugins = [ "git" "python" "man" "vi-mode" "docker" "docker-compose" ];
            # theme = "cypher"; # no git
            # theme = "robbyrussell"; # default
            # theme = "lambda"; # bw
            theme = "lukerandall"; # really cool - minimal and good
            # theme = "af-magic"; # good but has a vertival-line
            # # theme = "afowler"; # pretty good - the least
            # theme = "daveverwer"; # not bad
            # theme = "fishy"; # better - fish's
            # theme = "gentoo"; # best
            # theme = "kennethreitz"; # with rprompt - italic
        };
    };


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        linux-firmware
        vim
        xwallpaper
        librewolf
        gnupg
        mg
        tmux
        lxappearance
        nvi
        ed
        git
        fzf
        ncdu
        ripgrep
        pciutils
        lshw
        moreutils
        bc
        stow
        entr
        pwgen
        pass
        neovim
        highlight
        nnn
        wget
        aria2
        ffmpeg
        imagemagick
        htop
        nload
        qemu
        go
        groff
        gnumake
        gcc
        unzip
        lua54Packages.lua
        lua54Packages.luarocks
        proxychains
        dblatexFull
        # texlive
        texliveFull
        # texliveSmall
        # texlivePackages.xepersian
        # texlivePackages.bidi
        # texlivePackages.fontspec
        # texlivePackages.beamer
        pinentry
        pinentry-gnome3
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-gnome3;
    };
    # services.pcscd.enable = true;

    # fonts {{{
    nixpkgs.config.joypixels.acceptLicense = true;
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [ 
        fira-code
        fira-code-symbols
        fira-code-nerdfont
        ubuntu_font_family
        libertinus
        liberation_ttf
        joypixels
        # persian
        vazir-fonts
        sahel-fonts
        parastoo-fonts
      ];

      fontconfig = {
        defaultFonts = {
          serif = [  "Liberation Serif" "Parastoo" ];
          sansSerif = [ "Ubuntu" "Sahel" ];
          monospace = [ "Ubuntu Mono" ];
        };
      };
    };
    # fonts }}}

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.

    # networking.firewall.enable = false;
    networking = { 
        # wireless.enable = true;    # Enables wireless support via wpa_supplicant. 
        # proxy = { 
        #         default = "http://user:password@proxy:port/"; 
        #         noProxy = "127.0.0.1,localhost,internal.domain"; 
        # }; 
        firewall = { 
            # allowedTCPPorts = [ ... ]; 
            allowedUDPPorts = [ 53 67 ]; 
            # enable = false; 
        }; 
    }; 


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}
