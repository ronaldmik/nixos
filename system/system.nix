{ ... }:
{
  time.timeZone = "Europe/Amsterdam";

  services = {
    fstrim.enable = true; # SSD optimizer
    gvfs.enable = true; # USB Mounting
    blueman.enable = true; # Bluetooth
    tumbler.enable = true; # Image/video preview
  };

  # Cachix to prevent compilation of hyprland on nixos-rebuild
  nix.settings = {
    download-buffer-size = 250000000;
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://hyprland.cachix.org"
      "https://walker.cachix.org"
    ];
    
    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
    ];
  };

  system.stateVersion = "24.11";
}
