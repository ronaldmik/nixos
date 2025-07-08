{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    libnotify # for notification: swaync
    pavucontrol # for audiocontrol: waybar
  ];
}
