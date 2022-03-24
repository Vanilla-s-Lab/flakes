{ config, ... }:
{
  sops.secrets."gsconnect/certificate-pem" = {
    sopsFile = ../secrets/certificate-pem.yaml;
  } // { owner = "vanilla"; /* group = "users"; */ };
}
