{ config, ... }:
{
  sops.secrets."chaoxing/vanilla/username".sopsFile = ../secrets/chaoxing.yaml;
  sops.secrets."chaoxing/vanilla/username".owner = "vanilla";
  sops.secrets."chaoxing/vanilla/username".group = "users";

  sops.secrets."chaoxing/vanilla/password".sopsFile = ../secrets/chaoxing.yaml;
  sops.secrets."chaoxing/vanilla/password".owner = "vanilla";
  sops.secrets."chaoxing/vanilla/password".group = "users";
}
