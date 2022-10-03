{ config, ... }:
{
  sops.secrets."vultr-nix/token".sopsFile = ../secrets/vultr-nix.yaml;
  sops.secrets."vultr-nix/token".owner = "vanilla";
}
