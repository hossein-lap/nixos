{ pkgs, config, ... }:
{
  # Enable the Cinnamon Desktop Environment.
  services.xserver.desktopManager.budgie.enable = true;

  environment.systemPackages = with pkgs; [
    geany-with-vte
    vte
    guake
    rhythmbox
    mate.mate-terminal
  ];
}
