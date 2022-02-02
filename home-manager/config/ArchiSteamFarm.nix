{ pkgs, config, nixosConfig, ... }:
{
  home.packages = [
    pkgs.ArchiSteamFarm
  ];

  home.file.".config/archisteamfarm/config/ASF.json".text =
    builtins.toJSON { Statistics = false; UpdateChannel = 0; };

  home.file.".config/archisteamfarm/config/Vanilla.json".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.ArchiSteamFarm.path;
}
