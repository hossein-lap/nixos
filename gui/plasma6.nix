{ pkgs, ... }:
{
    # # Enable the KDE Plasma Desktop Environment.
    # services.desktopManager.plasma6.enable = true;
    # displayManager.defaultSession = "plasma";
    services = {
        desktopManager.plasma6.enable = true;
        displayManager = {
            sddm = {
                enable = true;
                wayland.enable = true;
            };
            defaultSession = "plasma";
        };
    };

    environment.systemPackages = with pkgs; [
        kdePackages.kate
        kdePackages.yakuake
        kdePackages.merkuro
    ];
}
