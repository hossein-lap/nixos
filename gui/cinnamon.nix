{ pkgs, config, ... }:
{
  # # Enable the Cinnamon Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.cinnamon.enable = true;
  services.cinnamon.apps.enable = true;

  environment.systemPackages = with pkgs; [
    geany-with-vte
    vte
    guake
    rhythmbox
  ];
}
