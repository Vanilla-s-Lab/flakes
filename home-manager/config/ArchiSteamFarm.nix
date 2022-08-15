{ pkgs, config, nixosConfig, ... }:
{
  home.packages = [
    pkgs.ArchiSteamFarm
  ];

  home.file.".config/archisteamfarm/config/ASF.json".text =
    builtins.toJSON ({ IPC = false; Statistics = false; UpdateChannel = 0; }
      // { CurrentCulture = "qps-Ploc"; Headless = true; });

  home.file.".config/archisteamfarm/config/Vanilla.json".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.ArchiSteamFarm.path;
}
