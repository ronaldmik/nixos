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
    script = ''
      for i in /sys/class/hwmon/hwmon*/temp*_input; 
      do
        if [[ "$(<$(dirname $i)/name)" == "kraken2023elite" ]]; then 
          ln -sf $i /var/kraken_coolant_temp_input
        fi
      done
    '';
  };
}
