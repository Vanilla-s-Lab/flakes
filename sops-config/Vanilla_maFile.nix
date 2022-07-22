{ config, ... }:
{
  sops.secrets."Vanilla_maFile/shared_secret".sopsFile = ../secrets/Vanilla_maFile.yaml;
  sops.secrets."Vanilla_maFile/identity_secret".sopsFile = ../secrets/Vanilla_maFile.yaml;

  sops.templates."Vanilla_maFile".owner = "vanilla";
  # sops.templates."Vanilla_maFile".group = "users";

  sops.templates."Vanilla_maFile".content = builtins.toJSON {
    "shared_secret" = config.sops.placeholder."Vanilla_maFile/shared_secret";
    "identity_secret" = config.sops.placeholder."Vanilla_maFile/identity_secret";
  };
}
