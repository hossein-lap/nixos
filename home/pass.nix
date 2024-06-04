{ config, pkgs, ... }:
{
  # pass
  programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "/run/media/hos/hosusb/.password-store/";
        PASSWORD_STORE_KEY = "hosteam01@gmail.com";
        PASSWORD_STORE_CLIP_TIME = "120";
      };
  };
}
