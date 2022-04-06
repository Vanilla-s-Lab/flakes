{ config, nixosConfig, ... }:
{
  home.file.".config/nix/nix.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.nix_conf.path;
}
