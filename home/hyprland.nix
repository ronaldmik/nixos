{ pkgs, lib, hyprland, ... }:
{
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprland-qtutils

    # For screensharing in Wayland apps, see also: https://wiki.hypr.land/Useful-Utilities/Screen-Sharing/
    libsForQt5.xwaylandvideobridge
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    settings = {
      env = [
        "NIXOS_OZONE_WL, 1"
      ];

      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "nm-applet --indicator"
      ];

      input = {
        numlock_by_default = true;
      };
      
      cursor = {
        sync_gsettings_theme = true;
        no_hardware_cursors = 2;
        enable_hyprcursor = false;
      };

      "$mod" = "SUPER";

      bindr = [
        "$mod, SUPER_L, exec, walker"
      ];

      bind = [
        "$mod, RETURN, exec, alacritty"
        "$mod, E, exec, thunar"
        "$mod, B, exec, firefox"
        "$mod, Q, killactive"
        "$mod, F, togglefloating"
        "$mod, M, fullscreen"
        # "ALT, RETURN, fullscreen" Dit is ook een IntelliJ-bind

        ", Print, exec, ${lib.getExe pkgs.hyprshot} --mode output --raw | ${lib.getExe pkgs.satty} --filename -"
        "$mod, Print, exec, ${lib.getExe pkgs.hyprshot} --mode window --raw | ${lib.getExe pkgs.satty} --filename -"
        "SHIFT, Print, exec, ${lib.getExe pkgs.hyprshot} --mode region --raw | ${lib.getExe pkgs.satty} --filename -"

        # Change focus        
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, TAB, cyclenext"
        "$mod, TAB, bringactivetotop"
        "$mod SHIFT, TAB, cyclenext, prev"
        "$mod SHIFT, TAB, bringactivetotop"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 0"
        "$mod,SPACE,togglespecialworkspace"

       # Move windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 0"
        "$mod SHIFT,SPACE,movetoworkspace,special"

      ];

      bindm = [
        "$modifier, mouse:272, movewindow"
        "$modifier, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "tag +file-manager, class:^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "tag +terminal, class:^(com.mitchellh.ghostty|org.wezfurlong.wezterm|Alacritty|kitty|kitty-dropterm)$"
        "tag +browser, class:^(Brave-browser(-beta|-dev|-unstable)?)$"
        "tag +browser, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
        "tag +browser, class:^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
        "tag +browser, class:^([Tt]horium-browser|[Cc]achy-browser)$"
        "tag +projects, class:^(codium|codium-url-handler|VSCodium)$"
        "tag +projects, class:^(VSCode|code-url-handler)$"
        "tag +im, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
        "tag +im, class:^([Ff]erdium)$"
        "tag +im, class:^([Ww]hatsapp-for-linux)$"
        "tag +im, class:^(teams-for-linux)$"
        "tag +games, class:^(gamescope)$"
        "tag +games, class:^(steam_app_\d+)$"
        "tag +gamestore, class:^([Ss]team)$"
        "tag +gamestore, title:^([Ll]utris)$"
        "tag +settings, class:^(gnome-disks|wihotspot(-gui)?)$"
        "tag +settings, class:^([Rr]ofi)$"
        "tag +settings, class:^(file-roller|org.gnome.FileRoller)$"
        "tag +settings, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
        "tag +settings, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "tag +settings, class:^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
        "tag +settings, class:(xdg-desktop-portal-gtk)"
        "tag +settings, class:(.blueman-manager-wrapped)"
        "tag +settings, class:(nwg-displays)"
        "move 72% 7%,title:^(Picture-in-Picture)$"
        "center, class:^([Ff]erdium)$"
        "float, class:^([Ww]aypaper)$"
        "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "center, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
        "center, title:^(Authentication Required)$"
        "idleinhibit fullscreen, class:^(*)$"
        "idleinhibit fullscreen, title:^(*)$"
        "idleinhibit fullscreen, fullscreen:1"
        "float, tag:settings*"
        "float, class:^([Ff]erdium)$"
        "float, title:^(Picture-in-Picture)$"
        "float, class:^(mpv|com.github.rafostar.Clapper)$"
        "float, title:^(Authentication Required)$"
        "float, class:(codium|codium-url-handler|VSCodium), title:negative:(.*codium.*|.*VSCodium.*)"
        "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
        "float, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
        "float, initialTitle:(Add Folder to Workspace)"
        "float, initialTitle:(Open Files)"
        "float, initialTitle:(wants to save)"
        "size 70% 60%, initialTitle:(Open Files)"
        "size 70% 60%, initialTitle:(Add Folder to Workspace)"
        "size 70% 70%, tag:settings*"
        "size 60% 70%, class:^([Ff]erdium)$"
        "opacity 1.0 1.0, tag:browser*"
        "opacity 0.9 0.8, tag:projects*"
        "opacity 0.94 0.86, tag:im*"
        "opacity 0.9 0.8, tag:file-manager*"
        "opacity 0.8 0.7, tag:terminal*"
        "opacity 0.8 0.7, tag:settings*"
        "opacity 0.8 0.7, class:^(gedit|org.gnome.TextEditor|mousepad)$"
        "opacity 0.9 0.8, class:^(seahorse)$ # gnome-keyring gui"
        "opacity 0.95 0.75, title:^(Picture-in-Picture)$"

        "pin, title:^(Picture-in-Picture)$"
        "keepaspectratio, title:^(Picture-in-Picture)$"
        "noblur, tag:games*"
        "fullscreen, tag:games*"

        "tag +jb, class:^jetbrains-.+$,floating:1"
        "stayfocused, tag:jb"
        "noinitialfocus, tag:jb"
        "focusonactivate, class:^jetbrains-(?!toolbox)"
      ];
    };
  };
}
