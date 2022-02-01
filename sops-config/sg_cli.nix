{ config, ... }:
{
  sops.secrets."sg_cli/secret".sopsFile =
    ../secrets/sg_cli.yaml;

  sops.templates.sg_cli.owner = "vanilla";
  sops.templates.sg_cli.group = "users";

  sops.templates.sg_cli.content = ''
    [sg_cli]
    secret = "${config.sops.placeholder."sg_cli/secret"}"
  '';
}
