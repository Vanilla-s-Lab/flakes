{ config, ... }:
{
  sops.secrets."hysteria/server".sopsFile = ../secrets/hysteria.yaml;
  sops.secrets."hysteria/auth_str".sopsFile = ../secrets/hysteria.yaml;
  sops.secrets."hysteria/server_name".sopsFile = ../secrets/hysteria.yaml;
  sops.secrets."hysteria/obfs".sopsFile = ../secrets/hysteria.yaml;

  sops.templates.hysteria.owner = "vanilla";
  sops.templates.hysteria.group = "users";

  sops.templates.hysteria.content = builtins.toJSON {
    server = config.sops.placeholder."hysteria/server";
    auth_str = config.sops.placeholder."hysteria/auth_str";
    server_name = config.sops.placeholder."hysteria/server_name";

    up_mbps = 100;
    down_mbps = 300;

    obfs = config.sops.placeholder."hysteria/obfs";

    socks5.listen = "127.0.0.1:1080";
    http.listen = "127.0.0.1:8080";
  };
}
