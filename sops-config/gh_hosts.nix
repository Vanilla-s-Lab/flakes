{ config, ... }:
{
  sops.secrets."gh_hosts/oauth_token".sopsFile =
    ../secrets/gh_hosts.yaml;

  sops.templates."gh_hosts".owner = "vanilla";
  # sops.templates."gh_hosts".group = "users";

  sops.templates."gh_hosts".content = ''
    github.com:
        user: VergeDX
        oauth_token: ${config.sops.placeholder."gh_hosts/oauth_token"}
        git_protocol: ssh
  '';
}
