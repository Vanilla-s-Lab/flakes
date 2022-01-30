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
}