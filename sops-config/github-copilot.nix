{ config, ... }:
{
  sops.secrets."github-copilot/user".sopsFile = ../secrets/github-copilot.yaml;
  sops.secrets."github-copilot/oauth_token".sopsFile = ../secrets/github-copilot.yaml;

  sops.templates.github-copilot.owner = "vanilla";
  # sops.templates.github-copilot.group = "users";

  sops.templates.github-copilot.content = builtins.toJSON {
    "github.com" = {
      user = config.sops.placeholder."github-copilot/user";
      oauth_token = config.sops.placeholder."github-copilot/oauth_token";
    };
  };
}
