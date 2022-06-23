{ config, ... }:
{
  sops.secrets."openfortivpn/host".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/port".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/username".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/password".sopsFile = ../secrets/openfortivpn.yaml;
  sops.secrets."openfortivpn/trusted-cert".sopsFile = ../secrets/openfortivpn.yaml;
}
