# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ ./hardware/default.nix
      ./user/default.nix
      ./gui/default.nix
      # <home-manager/nixos>
    ];

  nixpkgs.overlays = [
    (import ./overlay/st.nix)
    (import ./overlay/tabbed.nix)
  ];

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelParams = ["quiet"];
  # boot.plymouth.enable = true;

  networking.hostName = "primejade";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  # Configure X11
  services.xserver = {
    # dpi = 120;
    # xkb.layout = "us";
    xkb.variant = "";
    xkb.layout = "us,ir";
    xkb.options = "grp:alt_caps_toggle";
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

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.joypixels.acceptLicense = true;

  networking = {
      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      # proxy = {
      #     default = "http://user:password@proxy:port/";
      #     noProxy = "127.0.0.1,localhost,internal.domain";
      # };
      firewall = {
          # allowedTCPPorts = [ ... ];
          allowedUDPPorts = [ 53 67 ];
          # enable = false;
      };
  };

  # docker installation
  virtualisation = {
      docker.enable = true;
      waydroid.enable = true;
      libvirtd.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

    # fonts {{{
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

  environment.systemPackages = with pkgs; [
    # Nano is installed by default
    home-manager
    weston
    bc
    ed
    stow
    pwgen
    vim_configurable
    neovim
    mg
    fzf
    ripgrep
    fd
    highlight
    git
    tmux
    st

  #     (st.overrideAttrs (oldAttrs: rec {
  #   # src = fetchFromGitHub {
  #   #   owner = "LukeSmithxyz";
  #   #   repo = "st";
  #   #   rev = "8ab3d03681479263a11b05f7f1b53157f61e8c3b";
  #   #   sha256 = "1brwnyi1hr56840cdx0qw2y19hpr0haw4la9n0rqdn0r2chl8vag";
  #   # };
  #   # Make sure you include whatever dependencies the fork needs to build properly!
  #   buildInputs = oldAttrs.buildInputs ++ [ harfbuzz ];
  # # If you want it to be always up to date use fetchTarball instead of fetchFromGitHub
  # src = builtins.fetchTarball {
  #   url = "https://gitlab.com/hos-workflow/st/-/archive/master/st-master.tar.gz";
  # };
  # }))

    screen
    wget
    aria2
    ffmpeg
    btop
    imagemagick
    mksh
    nsxiv
    libvirt
    qemu
    # LSPs
    clang-tools_18
    lua-language-server
    ruby-lsp
    gopls
    # LSPs
    ruby
    mpv
    mpd
    nekoray
    proxychains
    yt-dlp
    gcc
    gnumake
    groff
    pandoc
    asciidoctor-with-extensions
    go
    nnn
    pciutils
    moreutils
    entr
    nodejs_22
    unzip
    julia-lts
    python312Full
    lua54Packages.lua
    lua54Packages.luarocks
  ];

  # android
  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  # shells
  # programs.zsh.enable = true;
  environment.shells = with pkgs; [ bash ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
