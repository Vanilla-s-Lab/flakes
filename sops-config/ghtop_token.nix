{ config, ... }:
{
  sops.secrets."ghtop_token/token".sopsFile =
    ../secrets/ghtop_token.yaml;

  sops.secrets."ghtop_token/token".owner = "vanilla";
  # sops.secrets."ghtop_token/token".group = "users";
}
