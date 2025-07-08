{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    liquidctl
  ];

  systemd.services.liquidd = {
    description = "Set fan curves for Kraken AIO with liquidctl";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.liquidctl}/bin/liquidctl initialize all"
        "${pkgs.liquidctl}/bin/liquidctl --match kraken set pump speed 20 50 30 55 40 60 50 75 60 100"
        "${pkgs.liquidctl}/bin/liquidctl --match kraken set fan speed 20 20 30 30 35 50 40 80 45 90 50 100"
      ];
    };
  };
}
