{ pkgs, hostname, ... }:
{
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
