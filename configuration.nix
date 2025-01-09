# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	nixpkgs.overlays = [
		(import ./overlay/st.nix)
		(import ./overlay/farbfeld.nix)
		# (import ./overlay/tabbed.nix)	# compile stage error
		# (import ./overlay/dmenu.nix)	# fribidi.h header not found
		# (import ./overlay/dwmblocks.nix)
		# (import ./overlay/dwm.nix)
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# kvm
	virtualisation = {
		virtualbox.host.enable = true;
		libvirtd.enable = true;
		docker = {
			enable = true;
			extraOptions = "--registry-mirror https://docker.arvancloud.ir --insecure-registry https://docker.arvancloud.ir";
		};
		podman = {
			enable = true;
			# dockerCompat = true;
		};
		waydroid.enable = true;
	};
	boot.kernelModules = [ "kvm-intel" ];
	# boot.kernelModules = [ "kvm-intel" "vboxdrv" "vboxnetadp" "vboxnetflt" ];

	networking.hostName = "nix-work"; # Define your hostname.
	networking.extraHosts = ''
		192.168.30.23 peyman-virt
	'';

	# networking.wireless.enable = true;	# Enables wireless support via wpa_supplicant.

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
	services.xserver = {
		dpi = 120;
		# xkb.layout = "us";
		xkb.variant = "";
		xkb.layout = "us,ir";
		xkb.options = "grp:alt_caps_toggle";
	};

	services.displayManager.ly.enable = true;

	# # Enable the Cinnamon Desktop Environment.
	# services.displayManager.ly = {
	#	 enable = true;
	#	 # settings.setup_cmd = ''
	#	 #	 xrandr --listactivemonitors \
	#	 #	 | awk -- 'BEGIN { getline } { gsub(/\/[[:digit:]]+/,"",$3) ; print $3 }' \
	#	 #	 | while read GEOMETRY; do
	#	 #	 x11vnc \
	#	 #		 -xkb \
	#	 #		 -noxrecord \
	#	 #		 -noxfixes \
	#	 #		 -noxdamage \
	#	 #		 -noxrecord \
	#	 #		 -shared \
	#	 #		 -forever \
	#	 #		 -reopen \
	#	 #		 -usepw \
	#	 #		 -rfbauth /home/hos/.vnc/passwd \
	#	 #		 -safer \
	#	 #		 -bg \
	#	 #		 -avahi \
	#	 #		 -clip $GEOMETRY
	#	 #		 # -localhost \
	#	 #	 done
	#	 # '';
	#	 # settings = ''
	#	 #	 
	#	 # '';
	# };

	services.xserver.windowManager.dwm.enable = true;
	services.dwm-status = {
		enable = true;
		order = [ "audio" "cpu_load" "network" "time" ];
		extraConfig = "
			separator = ' | '
			time = {
				format = '%Y-%m-%d, %H:%M:%S'
			}
		";
	};

	programs.slock.enable = true;

	services.xrdp.enable = true;
	services.xrdp.defaultWindowManager = "dwm";
	services.xrdp.openFirewall = true;

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
	services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users = {
		defaultUserShell = pkgs.bash;
		# extraGroups.vboxusers.members = [ "hos" ];
		users.hos = {
			isNormalUser = true;
			description = "hos";
			extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "qemu-libvortd" ];
			shell = pkgs.zsh;
			packages = with pkgs; [
			#	thunderbird
			];
		};
	};

	# Install firefox.
	programs.firefox.enable = true;
	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.joypixels.acceptLicense = true;

	fonts = {
		enableDefaultPackages = true;
		packages = with pkgs; [
			fira-code fira-code-symbols fira-code-nerdfont
			ubuntu_font_family
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

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.localBinInPath = true;
	environment.systemPackages = with pkgs; [
		# mine
		vim-full tmux fzf git mg fd highlight ripgrep bc screen ffmpeg nsxiv mksh
		zsh btop imagemagick mpv mpd mpc zsh lf nnn entr groff pandoc unzip
		pciutils moreutils asciidoctor-with-extensions xterm xclip tree-sitter hugo
		fastfetch ueberzug emacs btop terminator zathura unrar rofi dunst links2
		st dmenu tabbed dwmblocks sxhkd xwallpaper lxappearance libnotify
		texliveFull xcompmgr libreoffice tree jcal pulsemixer tigervnc krdc
		lowdown lsof nmap farbfeld sent

		# docuemnts
		linux-manual man-pages man-pages-posix

		# password
		pass pwgen

		# config tools
		stow

		# dev tools
		julia-lts go gcc ruby lua54Packages.lua
		lua54Packages.luarocks nodejs_22 python312Packages.pipx python312Full
		gdb libsForQt5.qca kdePackages.qca pipx

		(perl.withPackages(ps: [ ps.ImageMagick ]))

		cmake gnumake
		qt5.full qtcreator

		bash-language-server clang-tools_18 cmake-language-server docker-ls gopls
		lua-language-server nixd perlnavigator pyright ruby-lsp vim-language-server
		texlab yaml-language-server

		# vm / container
		docker docker-buildx docker-compose distrobox
		qemu qemu_kvm qemu-user qemu-utils
		weston # wayland compositor for using waydroid
		cage

		# download
		wget aria2 curl nekoray yt-dlp uget

		# editor
		gimp-with-plugins

		# browser
		google-chrome

		# misc
		obs-studio

		# theme
		simp1e-cursors libsForQt5.qtstyleplugin-kvantum libsForQt5.qt5ct

		# others
		nfs-utils

	];

	# man.generateCaches = true;

	qt = {
		enable = true;
		style = "kvantum";
		platformTheme = "qt5ct";
	};

	# nixpkgs.config = {
	# 	st.conf = builtins.readFile "/home/hos/.local/hos/workflow/st/config.def.h";
	# };


	#nixpkgs.config.qt5 = {
	#	enable = true;
	#	platformTheme = "qt5ct";
	#	#	style = {
	#	#		package = pkgs.utterly-nord-plasma;
	#	#		name = "Utterly Nord Plasma";
	#	#	};
	#};

	environment.sessionVariables = {
		QT_QPA_PLATFORMTHEME = "qt5ct";
		QT_STYLE_OVERRIDE = "kvantum";
		EDITOR = "vim";
		VISUAL = "vim";
		SUDO_EDITOR = "vim";
		SYSTEMD_EDITOR = "vim";
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
	};


	programs.proxychains = {
		enable = true;
		proxies = {
			prx1 = {
				enable = true;
				type = "socks5";
				host = "127.0.0.1";
				port = 2080;
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

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	# # Open ports in the firewall.
	networking.firewall.allowedTCPPorts = [ 22 1234 ];
	networking.firewall.allowedUDPPorts = [ 22 1234 ];
	# Or disable the firewall altogether.
	networking.firewall.enable = true;

	documentation.enable = true;
	documentation.man.man-db.enable = true;
	documentation.dev.enable = true;
	documentation.info.enable = true;
	documentation.man.enable = true;
	documentation.doc.enable = true;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
