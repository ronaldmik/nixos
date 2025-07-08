{ stylix, ... }:
{
  imports = [
    ./boot.nix
    ./greetd.nix
    ./hardware-configuration.nix
    ./hyprland.nix
    ./liquidctl.nix
    ./networking.nix
    ./packages.nix
    ./pipewire.nix
    ./roon.nix
    ./security.nix
    ./steam.nix
    ./stylix.nix
    ./system.nix
    ./thunar.nix
    ./user.nix
    ./xserver.nix
    stylix.nixosModules.stylix
  ];
}
