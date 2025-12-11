{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    openfortivpn
    openconnect
  ];

  networking.extraHosts = ''
    127.0.0.1   localhost
  '';
}
