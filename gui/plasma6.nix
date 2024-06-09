{ pkgs, ... }:
{
    # # Enable the KDE Plasma Desktop Environment.
    # services.displayManager.sddm.enable = true;
    # services.desktopManager.plasma6.enable = true;
    # displayManager.defaultSession = "plasma";
    services = {
        displayManager.sddm.enable = true;
        desktopManager = {
            plasma6.enable = true;
        };
        displayManager.defaultSession = "plasma";
    };

    environment.systemPackages = with pkgs; [
        kdePackages.kate
        kdePackages.yakuake
        kdePackages.merkuro
    ];
}
