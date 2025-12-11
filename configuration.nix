# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

  let
    hostname = "metalbook";
    username = "hos";
  in {
    imports =
      [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./work/default.nix
      ];

    # # flakes
    # nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "${hostname}"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Tehran";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Cinnamon Desktop Environment.
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;

    # Configure keymap in X11
    services.xserver = {
      # dpi = 120;
      xkb.variant = "";
      xkb.layout = "us,ir";
      xkb.options = "grp:alt_caps_toggle";
    };

    # remote desktop protocol (RDP)
    # services.xrdp.enable = true;
    # services.xrdp.defaultWindowManager = "cinnamon";
    # services.xrdp.openFirewall = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
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
    services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
      defaultUserShell = pkgs.bash;
      extraGroups.vboxusers.members = [ "${username}" ];
      users.${username} = {
        isNormalUser = true;
        description = "Hos";
        uid = 1000;
        extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "qemu-libvortd" ];
        home = "/home/${username}";
        shell = pkgs.zsh;
        packages = with pkgs; [
    # home-manager
    geany-with-vte vte guake rhythmbox
    gimp-with-plugins
    google-chrome
    obs-studio
    throne
    uget
    emacs
    terminator
    lxappearance
    tigervnc
    kdePackages.krdc
    remmina
    libreoffice
    # telegram-desktop
    # discord
        ];
      };
    };

    # Install firefox.
    programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # fonts
    nixpkgs.config.joypixels.acceptLicense = true;
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        fira-code fira-code-symbols nerd-fonts.fira-code
        ubuntu-classic
        libertinus liberation_ttf
        joypixels
        notonoto
        newcomputermodern
        freefont_ttf
        source-sans-pro
        # persian
        vazir-fonts sahel-fonts parastoo-fonts
      ];

      fontconfig = {
        defaultFonts = {
    serif = [ "Liberation Serif" "Libertinus Serif" "Parastoo" ];
    sansSerif = [ "Ubuntu" "Source Sans Pro" "Sahel" ];
    monospace = [ "Noto Sans Mono" "Ubuntu Mono" ];
        };
      };
    };

    environment.localBinInPath = true;
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # mine
      vim-full tmux fzf git mg fd highlight ripgrep bc screen ffmpeg nsxiv mksh
      btop imagemagick mpv mpd mpc zsh lf nnn entr groff pandoc unzip
      pciutils moreutils asciidoctor-with-extensions xterm xclip tree-sitter hugo
      fastfetch ueberzug btop zathura unrar rofi dunst links2
      sxhkd xwallpaper libnotify texliveFull xcompmgr tree jcal pulsemixer
      lowdown lsof nmap farbfeld sent pywal

      # docuemnts
      linux-manual man-pages man-pages-posix

      # password
      pass pwgen

      # config tools
      stow

      # dev tools
      julia-lts go gcc ruby lua54Packages.lua
      lua54Packages.luarocks nodejs_22 python3
      gdb kdePackages.qca pipx
      java-language-server groovy

      (perl.withPackages(ps: [ ps.ImageMagick ]))

      cmake gnumake fribidi harfbuzz pkg-config
      # qt5.full qtcreator

      bash-language-server clang-tools cmake-language-server docker-ls gopls
      lua-language-server nixd perlnavigator pyright ruby-lsp vim-language-server
      texlab yaml-language-server

      # vm / container
      docker docker-buildx docker-compose distrobox
      qemu qemu_kvm qemu-user qemu-utils
      # weston # wayland compositor for using waydroid
      # cage

      # download
      wget aria2 curl yt-dlp

      # theme
      simp1e-cursors kdePackages.qtstyleplugin-kvantum kdePackages.qt6ct

      # others
      nfs-utils

    ];

    # android
    programs.adb.enable = true;

    # # flakes
    # programs.nh = {
    #     enable = true;
    #     flake = "/home/${user}/.flake";
    #   };

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_STYLE_OVERRIDE = "kvantum";
      EDITOR = "vim";
      VISUAL = "vim";
      SUDO_EDITOR = "vim";
      SYSTEMD_EDITOR = "vim";
    };

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

    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    # services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };

    # List services that you want to enable:

    # V2rayA
    services.v2raya = {
      enable = true;
    };

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?

}
