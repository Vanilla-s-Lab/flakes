{ pkgs, config, ... }:
{
  programs.chromium.enable = true;
  programs.chromium.commandLineArgs =
    # https://wiki.archlinux.org/title/Chromium#Force_GPU_acceleration
    [ "--ignore-gpu-blocklist" "--enable-gpu-rasterization" "--enable-zero-copy" ];

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
}
