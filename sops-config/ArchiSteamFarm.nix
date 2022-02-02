{ config, ... }:
{
  sops.secrets."ArchiSteamFarm/Login".sopsFile = ../secrets/ArchiSteamFarm.yaml;
  sops.secrets."ArchiSteamFarm/Password".sopsFile = ../secrets/ArchiSteamFarm.yaml;

  sops.templates.ArchiSteamFarm.owner = "vanilla";
  sops.templates.ArchiSteamFarm.group = "users";

  sops.templates.ArchiSteamFarm.content = builtins.toJSON {
    SteamLogin = config.sops.placeholder."ArchiSteamFarm/Login";
    SteamPassword = config.sops.placeholder."ArchiSteamFarm/Password";
    Enabled = true;
  };
}
