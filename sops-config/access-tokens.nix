{ config, ... }:
{
  sops.secrets."nix/access-tokens".sopsFile = ../secrets/access-tokens.yaml;
  sops.secrets."nix/access-tokens".owner = "vanilla";
}
