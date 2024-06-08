{ config, ... }:

{
  imports =
  [ ./nvidia.nix
    ./hardware-configuration.nix
  ];
}
