{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.albert
    (pkgs.makeAutostartItem {
      name = "albert";
      package = pkgs.albert;
    })
  ];

  home.file.".config/albert".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/albert";
}
