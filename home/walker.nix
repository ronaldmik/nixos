{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libqalculate
  ];

  programs.walker = {
    enable = true;
    runAsService = true;

    # All options from the config.json can be used here.
    config = {
      search.placeholder = "Calling Elvis...";
      ui.fullscreen = false;
      list = {
        height = 320;
      };
      websearch.prefix = "?";
      switcher.prefix = "/";
      calc.prefix = "=";
    };

    # If this is not set the default styling is used.
    #style = ''
    #  * {
    #    color: #dcd7ba;
    #  }
    #'';
  };
}
