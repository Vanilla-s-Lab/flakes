{ config, ... }:
{
  sops.secrets."docker/auth".sopsFile =
    ../secrets/docker.yaml;

  sops.templates."docker".owner = "vanilla";
  # sops.templates."docker".group = "users";

  sops.templates."docker".content = builtins.toJSON {
    "auths"."ghcr.io"."auth" = config.sops.placeholder."docker/auth";
  };
}
