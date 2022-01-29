{ config, ... }:
{
  home.file.".cache/nix".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/nix";

  home.file."Projects".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Projects";
}
