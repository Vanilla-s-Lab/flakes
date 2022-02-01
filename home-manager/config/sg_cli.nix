{ config, nixosConfig, ... }:
{
  home.file.".sg_cli.toml".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.sg_cli.path;
}
