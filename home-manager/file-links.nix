{ config, ... }:
{
  home.file.".cache/nix".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/nix";

  home.file."Projects".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Projects";

  home.file.".config/monitors.xml".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/monitors.xml";

  home.file.".config/nixpkgs".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Projects/flakes/home-manager";

  home.file."Downloads".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Downloads";

  home.file."Pictures".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Pictures";

  home.file.".steam".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/steam";

  home.file.".local/share/Steam".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/Steam";
}
