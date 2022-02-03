{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.obs-studio
  ];

  home.file.".config/obs-studio".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/obs-studio";
}
