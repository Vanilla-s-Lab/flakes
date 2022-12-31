{ config, ... }:
{
  sops.secrets."linode-nix/token".sopsFile = ../secrets/linode-nix.yaml;
  sops.secrets."linode-nix/token".owner = "vanilla";
  # sops.secrets."linode-nix/token".group = "users";
}
