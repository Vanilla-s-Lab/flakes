{ pkgs, config, nixosConfig, ... }:
{
  home.packages = [ pkgs.nodePackages.pxder ];

  home.file.".config/pxder/config.json".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.pxder.path;
}
