{ config, lib, ... }:
{
  sops.secrets."openfortivpn/host".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/port".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/username".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/password".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/trusted-cert".sopsFile = ../secrets/openfortivpn.yaml;

  sops.templates.openfortivpn.content = lib.generators.toKeyValue
    { mkKeyValue = lib.generators.mkKeyValueDefault { } " = "; }
    {
      host = config.sops.placeholder."openfortivpn/host";
      port = config.sops.placeholder."openfortivpn/port";

      username = config.sops.placeholder."openfortivpn/username";
      password = config.sops.placeholder."openfortivpn/password";

      trusted-cert = config.sops.placeholder."openfortivpn/trusted-cert";
    };
}
