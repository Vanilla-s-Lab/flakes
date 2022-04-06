{ config, ... }:
{
  sops.secrets."nix/access-tokens".sopsFile = ../secrets/access-tokens.yaml;
  sops.secrets."nix/access-tokens".owner = "vanilla";
  sops.templates.nix_conf.owner = "vanilla";

  sops.templates.nix_conf.content = ''
    # https://nixos.org/manual/nix/unstable/command-ref/conf-file.html
    access-tokens = github.com=${config.sops.placeholder."nix/access-tokens"}
  '';
}
