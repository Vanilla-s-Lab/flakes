{ config, ... }:
{
  sops.secrets."dot-npmrc/authToken".sopsFile =
    ../secrets/dot-npmrc.yaml;

  sops.templates."dot-npmrc".owner = "vanilla";
  # sops.templates."dot-npmrc".group = "users";

  sops.templates."dot-npmrc".content = ''
    proxy=http://127.0.0.1:8889/
    https-proxy=http://127.0.0.1:8889/
    //npm.pkg.github.com/:_authToken=${config.sops.placeholder."dot-npmrc/authToken"}
  '';
}
