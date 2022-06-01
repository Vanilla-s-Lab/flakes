{ pkgs, config, inputs, system, ... }:
{
  programs.chromium.enable = true;
  programs.chromium.commandLineArgs =
    # https://wiki.archlinux.org/title/Chromium#Force_GPU_acceleration
    [ "--ignore-gpu-blocklist" "--enable-gpu-rasterization" "--enable-zero-copy" ]
    # https://wiki.archlinux.org/title/Chromium#Hardware_video_acceleration
    ++ [ "--enable-features=VaapiVideoDecoder" /* "--use-gl=egl" */ ]
    ++ [ "--disable-features=MediaRouter" ]; # issues 1218418.

  home.packages = [
    pkgs.tor-browser-bundle-bin
  ];

  # https://wiki.archlinux.org/title/chromium
  systemd.user.sessionVariables = {
    GOOGLE_DEFAULT_CLIENT_ID = "77185425430.apps.googleusercontent.com";
    GOOGLE_DEFAULT_CLIENT_SECRET = "OTJgUOQcT7lO7GsGZq2G4IlT";
  };

  home.file.".local/share/tor-browser".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/tor-browser";

  home.file.".config/chromium".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/chromium";

  home.file.".cache/chromium".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/chromium";

  programs.firefox.enable = true;
  # https://www.mozilla.org/en-US/firefox/developer/
  programs.firefox.package = pkgs.firefox-devedition-bin;

  # https://nix-community.github.io/home-manager/options.html
  programs.firefox.profiles."dev-edition-default" = {
    name = "dev-edition-default";

    settings = {
      # https://kb.mozillazine.org/Browser.startup.page
      "browser.startup.page" = 3;
      "browser.shell.checkDefaultBrowser" = false;

      # https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/browserSettings/overrideContentColorScheme
      "layout.css.prefers-color-scheme.content-override" = 2;
      "browser.display.use_system_colors" = true; # Manage Colors
      "media.eme.enabled" = true; # Play DRM-controlled content

      # Recommend [ extensions | features ] as you browse
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

      "network.proxy.type" = 4;
    };
  };
}
