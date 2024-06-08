{ config, pkgs, ... }:

#** NOTE that these are huge packages **#
{
  home.packages = with pkgs; [

    # the gates of hell xd
    steam

    # cli
    nudoku # sudoku
    bastet # tetris + some bastrad(?!)

    # # fps
    # xonotic # you know it ;)
    # urbanterror # tactical shooter
    # openarena # fast-paced 3D first-person shooter, similar to Quake III Arena
    # ioquake3 # community effort to continue supporting/developing Quake III Arena
    # assaultcube # first-person-shooter based on the Cube fps
    # warsow # FPS game designed for competitive gaming
    # sauerbraten # multi/single player FPS, the successor of the Cube FPS

    # # kart racing
    # superTuxKart # SuperTux Kart :)
    # srb2kart # classic styled kart racer

  ];
}
