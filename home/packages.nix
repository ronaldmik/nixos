{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    alacritty
    discord
    gedit
    hyprshot
    jellyflix
    jetbrains.idea-ultimate
    killall
    liquidctl
    lm_sensors
    p7zip
    teams-for-linux
    tree
    vlc
    vmware-horizon-client
  ];
}
