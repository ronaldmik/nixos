{ pkgs, hyprland, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
