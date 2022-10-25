{ config, ... }:
{
  sops.secrets."access-tokens/github".sopsFile =
    ../secrets/access-tokens.yaml;

  sops.templates."nix.conf".owner = "vanilla";
  sops.templates."nix.conf".content = ''
    access-tokens = github.com=${config.sops.placeholder."access-tokens/github"}
  '';
}
