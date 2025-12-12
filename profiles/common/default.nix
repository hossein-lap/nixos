{ pkgs, config, ... }:
{

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableBashCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		ohMyZsh = {
			enable = true;
			theme = "robbyrussell";  # gentoo robbyrussell
			# plugins = with pkgs; [
			#	 zsh-syntax-highlighting
			#	 zsh-autosuggestions
			#	 # zsh-history-substring-search
			# ];
		};
        # # ZSH_THEME="artix" # two line but one prompt no color
        # # ZSH_THEME="bureau" # two-line + no color
        # # ZSH_THEME="candy" # two line -- 24-hours
        # # ZSH_THEME="clean-hos" # two line but one prompt
        # # ZSH_THEME="crcandy" # two line -- 12-hours
        # # ZSH_THEME="dst" # two-line + rprompt time
        # # ZSH_THEME="essembeh" # choice
        # # ZSH_THEME="gentoo" # two line but one prompt
        # # ZSH_THEME="juanghurtado" # two-line + commit hash
        # # ZSH_THEME="lukerandall"  # cool default-like
        # # ZSH_THEME="minimal" # default norm prompt
        # # ZSH_THEME="robbyrussell"
        # # ZSH_THEME="xiong-chiamiov" # two line
        # case "$TERM" in
        #     linux) ZSH_THEME="minimal" ;;
        #     xterm|vt100) ZSH_THEME="essembeh" ;;
        #     tmux*color|screen*color*) ZSH_THEME="robbyrussell" ;;
        #     xterm*color) ZSH_THEME="lukerandall" ;;
        #     st*color|xterm*kitty|rxvt*color) ZSH_THEME="gentoo" ;;
        #     *) ZSH_THEME="artix" ;;
        # esac
		promptInit = ''
            ssh_connection_prompt=$(echo $SSH_CONNECTION | awk '{print $3;}')
            if [ -n "$ssh_connection_prompt" ]; then
                # PROMPT_THEME="sunrise"
                RPROMPT="(ssh: $ssh_connection_prompt)"
            fi
		'';
	};

	# enable sound with pipewire
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

	# networking.wireless.enable = true;	# Enables wireless support via wpa_supplicant

	# enable the x11 windowing system
	services.xserver.enable = true;

	# Enable the Cinnamon Desktop Environment
	services.xserver.displayManager.lightdm = {
		enable = true;
		greeters.enso.iconTheme.package = pkgs.papirus.icon.theme;
	};
	services.xserver.desktopManager.cinnamon.enable = true;

	# configure keymap in x11
	services.xserver = {
		# dpi = 120;
		xkb.variant = "";
		xkb.layout = "us,ir";
		xkb.options = "grp:alt_caps_toggle";
	};

	# Enable CUPS to print documents
	services.printing.enable = true;

    # nekoray alternative
	programs.throne = {
		enable = true;
		tunMode.enable = true;
	};

	# networking.proxy.default = "socks://127.0.0.1:20170";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# install firefox
	programs.firefox.enable = true;

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

	environment.systemPackages = with pkgs; [
		fd highlight ripgrep ffmpeg nsxiv mksh imagemagick mpv mpd mpc
		groff pandoc asciidoctor-with-extensions xterm xclip
		ueberzug zathura rofi dunst sxhkd xwallpaper libnotify texliveFull
		xcompmgr pulsemixer lowdown farbfeld sent pywal
		lua54Packages.luarocks gdb kdePackages.qca java-language-server
		(perl.withPackages(ps: [ ps.ImageMagick ]))
		cmake gnumake fribidi harfbuzz pkg-config
		bash-language-server clang-tools cmake-language-server docker-ls gopls
		lua-language-server nixd perlnavigator pyright ruby-lsp vim-language-server
		texlab yaml-language-server
		# weston # wayland compositor for using waydroid
		# cage
		simp1e-cursors kdePackages.qtstyleplugin-kvantum kdePackages.qt6ct
		matcha-gtk-theme
	];

	# android
	programs.adb.enable = true;

	environment.sessionVariables = {
		QT_QPA_PLATFORMTHEME = "qt6ct";
		QT_STYLE_OVERRIDE = "kvantum";
		EDITOR = "vim";
		VISUAL = "vim";
		SUDO_EDITOR = "vim";
		SYSTEMD_EDITOR = "vim";
	};

}
