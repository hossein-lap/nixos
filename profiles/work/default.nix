{ pkgs, config, ... }:
{

  imports = [
      ./sin.nix
  ];

  environment.systemPackages = with pkgs; [
    openfortivpn
    openconnect
  ];


  # remote desktop protocol (RDP)
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "cinnamon";
  services.xrdp.openFirewall = true;

  # networking.proxy.default = "socks://127.0.0.1:20170";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

}
