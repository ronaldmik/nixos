{ walker, ... }:
{
  imports = [
    ./firefox.nix
    ./git.nix
    ./gtk.nix
    ./hyprland.nix
    ./home.nix
    ./libation.nix
    ./packages.nix
    ./stylix.nix
    ./ssh.nix
    ./swaync.nix
    ./virtmanager.nix
    walker.homeManagerModules.default
    ./walker.nix
    ./waybar.nix
    ./wlogout.nix
    ./zsh.nix
  ];
}
