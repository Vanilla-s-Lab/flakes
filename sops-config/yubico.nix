{ config, ... }:
{
  sops.secrets."yubico/challenge-16155718".sopsFile =
    ../secrets/yubico.yaml;

  sops.templates."challenge-16155718".owner = "vanilla";
  sops.templates."challenge-16155718".group = "users";

  sops.templates."challenge-16155718".content =
    "${config.sops.placeholder."yubico/challenge-16155718"}";
}
