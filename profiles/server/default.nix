{ pkgs, config, ... }:
let
	username = "hos";
	hostname = "nixos-virt";
in
{

	# imports = [
	# 	./../common/default.nix
	# 	./../work/sin.nix
	# ];

	# hostname
	networking.hostName = "${hostname}";
	# user
	users = {
		defaultUserShell = pkgs.bash;
		users.${username} = {
			isNormalUser = true;
			description = "Hos";
			uid = 1000;
			extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "qemu-libvortd" ];
			home = "/home/${username}";
			shell = pkgs.zsh;
			packages = with pkgs; [
                # vim
			];
		};
	};

}
