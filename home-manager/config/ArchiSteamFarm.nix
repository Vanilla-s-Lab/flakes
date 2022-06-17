{ pkgs, config, nixosConfig, ... }:
{
  home.packages = [
    pkgs.ArchiSteamFarm
  ];

  home.file.".config/archisteamfarm/config/ASF.json".text =
    builtins.toJSON ({ IPC = false; Statistics = false; UpdateChannel = 0; }
      // { "SteamTokenDumperPluginEnabled" = true; }); # Support for steamdb.info!

  home.file.".config/archisteamfarm/config/Vanilla.json".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.ArchiSteamFarm.path;
}
