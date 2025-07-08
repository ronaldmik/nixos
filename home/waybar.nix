{
  pkgs,
  config,
  lib,
  ...
}: let
  terminal = "alacritty";
  base00 = "0F1419";
  base01 = "131721";
  base02 = "272D38";
  base03 = "3E4B59";
  base04 = "BFBDB6";
  base05 = "E6E1CF";
  base06 = "E6E1CF";
  base07 = "F3F4F5";
  base08 = "F07178";
  base09 = "FF8F40";
  base0A = "FFB454";
  base0B = "B8CC52";
  base0C = "95E6CB";
  base0D = "59C2FF";
  base0E = "D2A6FF";
  base0F = "E6B673";
in
  with lib; {
    # Configure & Theme Waybar
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";

          modules-center = ["network" "pulseaudio" "cpu" "temperature" "hyprland/workspaces" "memory" "disk" "clock#date" "clock"]; # Eterna: [ "hyprland/window" ]
          modules-left = ["custom/startmenu" "hyprland/window"]; # Eternal:  [ "hyprland/workspaces" "cpu" "memory" "network" ]
          modules-right = ["tray" "idle_inhibitor" "custom/notification" "battery" "custom/exit"]; # Eternal: [ "idle_inhibitor" "pulseaudio" "clock"  "custom/notification" "tray" ]

          "hyprland/workspaces" = {
            format = "{name}";
            format-icons = {
              default = " ";
              active = " ";
              urgent = " ";
            };
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };
          "clock#date" = {
            format = " {:%Y-%m-%d}";
            /*
            ''{: %I:%M %p}'';
            */
            tooltip = true;
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
          };
          "clock" = {
            interval = 1;
            format = " {:%H:%M:%S}";
          };
          "hyprland/window" = {
            max-length = 60;
            separate-outputs = false;
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
            on-click = "${terminal} -e btop";
          };
          "cpu" = {
            interval = 5;
            format = " {usage:2}%";
            tooltip = true;
            on-click = "${terminal} -e btop";
          };
          "temperature" = {
            interval = 5;
            format = "󱃂 {temperatureC}°C";
            # Find hwmon device: https://github.com/Alexays/Waybar/wiki/Module:-Temperature
            # for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done
            hwmon-path = "/sys/devices/pci0000:00/0000:00:01.2/0000:20:00.0/0000:21:08.0/0000:2a:00.3/usb3/3-6/3-6.4/3-6.4:1.0/0003:1E71:170E.0009/hwmon/hwmon4/temp1_input";
            critical-threshold = 60;
            format-critical = "󰸁 {temperatureC}°C"; 
          };
          "disk" = {
            format = " {free}";
            tooltip = true;
            # Not working with zaneyos window open then closes
            #on-click = "${terminal} -e sh -c df -h ; read";
          };
          "network" = {
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format-ethernet = " {bandwidthDownBits}";
            format-wifi = " {bandwidthDownBits}";
            format-disconnected = "󰤮";
            tooltip = false;
            on-click = "${terminal} -e btop";
          };
          "tray" = {
            spacing = 12;
          };
          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "pavucontrol";
          };
          "custom/exit" = {
            tooltip = false;
            format = "⏻";
            on-click = "sleep 0.1 && wlogout";
          };
          "custom/startmenu" = {
            tooltip = false;
            format = " ";
            on-click = "walker";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
            tooltip = "true";
          };
          "custom/notification" = {
            tooltip = false;
            format = "{icon} {}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t";
            escape = true;
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󱘖 {capacity}%";
            format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            on-click = "";
            tooltip = false;
          };
        }
      ];
      style = concatStrings [
        ''
          * {
            font-size: 16px;
            font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
            font-weight: bold;
          }
          window#waybar {
            /*

              background-color: rgba(26,27,38,0);
              border-bottom: 1px solid rgba(26,27,38,0);
              border-radius: 0px;
              color: #${base0F};
            */

            background-color: rgba(26,27,38,0);
            border-bottom: 1px solid rgba(26,27,38,0);
            border-radius: 0px;
            color: #${base0F};
          }
          #workspaces {
            /*
              Eternal
              background: linear-gradient(180deg, #${base00}, #${base01});
              margin: 5px 5px 5px 0px;
              padding: 0px 10px;
              border-radius: 0px 15px 50px 0px;
              border: 0px;
              font-style: normal;
              color: #${base00};
            */
            background: linear-gradient(45deg, #${base01}, #${base01});
            margin: 5px;
            padding: 0px 1px;
            border-radius: 15px;
            border: 0px;
            font-style: normal;
            color: #${base00};
          }
          #workspaces button {
            padding: 0px 5px;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: #${base00};
            background: linear-gradient(45deg, #${base0D}, #${base0E});
            opacity: 0.5;
            transition: all 0.3s ease-in-out;
          }
          #workspaces button.active {
            padding: 0px 5px;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: #${base00};
            background: linear-gradient(45deg, #${base0D}, #${base0E});
            opacity: 1.0;
            min-width: 40px;
            transition: all 0.3s ease-in-out;
          }
          #workspaces button:hover {
            border-radius: 15px;
            color: #${base00};
            background: linear-gradient(45deg, #${base0D}, #${base0E});
            opacity: 0.8;
          }
          tooltip {
            background: #${base00};
            border: 1px solid #${base0E};
            border-radius: 10px;
          }
          tooltip label {
            color: #${base07};
          }

          @keyframes blinking {
            0% {
              background: linear-gradient(45deg, #${base0D}, #${base0E});
            }
            100% {
              background: linear-gradient(45deg, #${base01}, #${base08});
            }
          }

          #workspaces button.urgent {
            padding: 0px 5px;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: #${base00};
            animation: blinking alternate 0.5s infinite;
            opacity: 0.5;
            transition: all 0.3s ease-in-out;
          }
          #window {
            /*
              Eternal
              color: #${base05};
              background: #${base00};
              border-radius: 15px;
              margin: 5px;
              padding: 2px 20px;
            */
            margin: 5px;
            padding: 2px 20px;
            color: #${base05};
            background: #${base01};
            border-radius: 50px 15px 50px 15px;
          }
          #memory {
            color: #${base0F};
            /*
              Eternal
              background: #${base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
            */
            background: #${base01};
            margin: 5px;
            padding: 2px 20px;
            border-radius: 15px 50px 15px 50px;
          }
          #clock {
            color: #${base0B};
              background: #${base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
          }
          #idle_inhibitor {
            color: #${base0A};
              background: #${base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
          }
          #cpu {
            color: #${base07};
              background: #${base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
          }
          #temperature {
            color: #${base09};
            background: #${base00};
            border-radius: 50px 15px 50px 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #disk {
            color: #${base0F};
              background: #${base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
          }
          #battery {
            color: #${base08};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #network {
            color: #${base09};
            background: #${base00};
            border-radius: 50px 15px 50px 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #tray {
            color: #${base05};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #pulseaudio {
            color: #${base0D};
            /*
              Eternal
              background: #${base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            */
            background: #${base01};
            margin: 4px;
            padding: 2px 20px;
            border-radius: 50px 15px 50px 15px;
          }
          #custom-notification {
            color: #${base0C};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #custom-startmenu {
            color: #${base0E};
            background: #${base00};
            border-radius: 0px 15px 50px 0px;
            margin: 5px 5px 5px 0px;
            padding: 2px 20px;
          }
          #idle_inhibitor {
            color: #${base09};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #custom-exit {
            color: #${base0E};
            background: #${base00};
            border-radius: 15px 0px 0px 50px;
            margin: 5px 0px 5px 5px;
            padding: 2px 20px;
          }
        ''
      ];
    };
  }

