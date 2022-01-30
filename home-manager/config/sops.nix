{ pkgs, config, ... }:
{
  home.packages = [ pkgs.sops ];
  home.file.".config/sops/age/keys.txt".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/sops/age/keys.txt";
}
