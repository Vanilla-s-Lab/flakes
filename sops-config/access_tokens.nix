{ config, ... }:
{
  sops.secrets."access_tokens".sopsFile =
    ../secrets/access_tokens.yaml;

  sops.templates."config.yml".owner = "vanilla";
  sops.templates."config.yml".content = ''
    access_token: ${config.sops.placeholder."access_tokens"}
  '';
}
