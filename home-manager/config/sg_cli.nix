{ config, nixosConfig, pkgs, ... }:
{
  home.packages = [
    pkgs.nodePackages.clipboard-cli
    pkgs.xsel
    (pkgs.callPackage ../packages/sg_cli.nix { })
  ];

  home.file.".sg_cli.toml".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.sg_cli.path;
}
