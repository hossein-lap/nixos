{ config, pkgs, ... }:

{
  home.packages = with pkgs;
  [ nudoku
    bastet
    steam
    # pkgs.tcsh
    # pkgs.mksh
    # pkgs.bash
  ];
}
