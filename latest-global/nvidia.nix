{ pkgs, config, lib, ... }:

{
    services.xserver.videoDrivers = ["nvidia"];
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        # extraPackages = with pkgs; [ vaapiVdpau ];

    };

    hardware = {
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;

            # prime = {
            #     # sync.enable = true;
            #     nvidiaBusId = "PCI:0:0:2";
            #     intelBusId = "PCI:0:1:0";
            # };

            # package = config.boot.kernelPackages.nvidiaPackages.production;
            # package = config.boot.kernelPackages.nvidiaPackages.stable;

            # Special config to load the latest (535 or 550) driver for the support of the 4070 SUPER
            package =
            let rcu_patch = pkgs.fetchpatch {
                url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
                hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
            };
            in config.boot.kernelPackages.nvidiaPackages.mkDriver {
                version = "535.154.05";
                sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
                sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
                openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
                settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
                persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
                # --
                #version = "550.40.07";
                #sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
                #sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
                #openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
                #settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
                #persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";
                patches = [ rcu_patch ];
            };

        };
    };

    specialisation = let
        iBusID = "PCI:0:2:0";
        nvBusID = "PCI:1:0:0";
    in {
        offload.configuration = {
            system.nixos.tags = [ "offload" ];
            environment.variables = { NIXOS_NVIDIA_CONFIG_TYPE = "offload"; };
            hardware.nvidia = {
                prime = {
                    offload.enable = lib.mkForce true;
                    offload.enableOffloadCmd = lib.mkForce true;
                    sync.enable = lib.mkForce false;
                    nvidiaBusId = nvBusID;
                    intelBusId = iBusID;
                };
            };
        };
        sync.configuration = {
            boot.kernelModules = [ "kvm-intel" "nvidia" "nvidia_drm" ];
            system.nixos.tags = [ "sync" ];
            environment.variables = { NIXOS_NVIDIA_CONFIG_TYPE = "sync"; };
            hardware.nvidia = {
                prime = {
                    offload.enable = lib.mkForce false;
                    offload.enableOffloadCmd = lib.mkForce false;
                    sync.enable = lib.mkForce true;
                    nvidiaBusId = nvBusID;
                    intelBusId = iBusID;
                };
            };
        };
    };

}
