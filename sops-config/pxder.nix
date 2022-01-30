{ config, ... }:
{
  sops.defaultSopsFile = ../secrets/default.yaml;
  sops.secrets."pxder/token" = { };

  sops.templates.pxder.owner = "vanilla";
  sops.templates.pxder.group = "users";

  sops.templates.pxder.content = builtins.toJSON {
    "download" = {
      "thread" = 32;
      "path" = "/home/vanilla/Pictures/pxder";
      "autoRename" = true;
    };

    "directMode" = true;
    "proxy" = "disable";

    "refresh_token" =
      config.sops.placeholder."pxder/token";
  };
}
