{ firefox-addons, ... }:

{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        extensions.packages = with firefox-addons.packages."x86_64-linux"; [
#          darkreader
#          ff2mpv
          kagi-search
          proton-pass
          # auto-accepts cookies, use only with privacy-badger & ublock-origin
          i-dont-care-about-cookies
          privacy-badger
          ublock-origin
          unpaywall
        ];

        settings = {
          # First launch
          "app.normandy.first_run" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.rights.3.shown" = true;
          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
     
          # Force WebGL. See: 
          # https://support.mozilla.org/en-US/questions/1334668
          # https://wiki.archlinux.org/title/Firefox/Tweaks  section: 4.14
          "webgl.force-enabled" = true;

          # New tab page junk
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.weatherfeed" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showWeather" = false;
          "browser.newtabpage.activity-stream.system.showSponsored" = false;
          "browser.newtabpage.activity-stream.system.showWeather" = false;
          "browser.newtabpage.activity-stream.weather.locationSearchEnabled" = false;

          # Search junk
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.yelp" = false;

          # Addons junk
          "extensions.htmlaboutaddons.recommendations.enabled" = false;

          # Pocket junk
          "browser.urlbar.suggest.pocket" = false;
          "extensions.pocket.enabled" = false;

          # Prevent Firefox from warning before going to about:config
          "browser.aboutConfig.showWarning" = false;

          # Don't try to store passwords. Using Bitwarden for this
          "signon.rememberSignons" = false;

          # Don't worry about missing session files (deleted via impermanence)
          "browser.sessionstore.max_resumed_crashes" = -1;

          # Prevent Firefox from suggesting to re-open tabs from last session
          "browser.startup.couldRestoreSession.count" = -1;

          # Default Ctrl-F to highlight all results by default
          "findbar.highlightAll" = true;

          # Allow extensions to be auto-enabled
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };
}
