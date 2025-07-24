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
        "${pkgs.liquidctl}/bin/liquidctl --match kraken set pump speed 20 50 28 60 30 65 32 70 33 80 40 100"
        "${pkgs.liquidctl}/bin/liquidctl --match kraken set fan  speed 20 20 28 30 30 40 32 50 33 60 40 100"
      ];
    };
    script = ''
      found=false
      for i in /sys/class/hwmon/hwmon*/temp*_input; 
      do
        if [[ "$(<$(dirname $i)/name)" == "kraken2023elite" ]]; then 
          echo 'Kraken found! Creating symlink to coolant temp for target [$i]'
          ln -sf $i /var/kraken_coolant_temp_input
          found=true
        fi
      done
      if [ "$found" = false ]; then
        echo 'Kraken not found! Not creating symlink to coolant temp.'
      fi
    '';
  };
}
