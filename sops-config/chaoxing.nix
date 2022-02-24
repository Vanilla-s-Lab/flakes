{ config, ... }:
{
  sops.secrets."chaoxing/username".sopsFile = ../secrets/chaoxing.yaml;
  sops.secrets."chaoxing/password".sopsFile = ../secrets/chaoxing.yaml;
}
