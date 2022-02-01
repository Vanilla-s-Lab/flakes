{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.android-tools
  ];

  home.file.".android".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/android";
}
