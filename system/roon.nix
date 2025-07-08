_:
{
  services.roon-bridge = {
    enable = true;
    openFirewall = true;
  };

  # TODO: Om een of andere reden moeten deze ports ook open, naast openFirewall hierboven. Uitzoeken of dit aan roon-server ligt...
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 33935;
        to = 65535;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 33935;
        to = 65535;
      }
    ];

  };
}
