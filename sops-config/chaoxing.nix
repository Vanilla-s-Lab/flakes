{ config, ... }:
{
  sops.secrets."chaoxing/username".sopsFile = ../secrets/chaoxing.yaml;
  sops.secrets."chaoxing/username".owner = "vanilla";
  sops.secrets."chaoxing/username".group = "users";

  sops.secrets."chaoxing/password".sopsFile = ../secrets/chaoxing.yaml;
  sops.secrets."chaoxing/password".owner = "vanilla";
  sops.secrets."chaoxing/password".group = "users";
}
