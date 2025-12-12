{ pkgs, config, ... }:
let
	username = "hos";
	hostname = "primejade";
in
{
	imports = [
		./../common/default.nix
		./../work/sin.nix
	];

	# hostname
	networking.hostName = "${hostname}";
	# user
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
				geany-with-vte vte guake rhythmbox
				gimp-with-plugins
				google-chrome
				obs-studio
				uget
				emacs
				terminator
				lxappearance
				kdePackages.krdc
				remmina
				libreoffice
				telegram-desktop
				discord
			];
		};
	};

}
