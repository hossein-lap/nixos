{ config, pkgs, ... }:

{
  home.packages =
  [ pkgs.nudoku
    # pkgs.tcsh
    # pkgs.mksh
    # pkgs.bash
  ];
}
