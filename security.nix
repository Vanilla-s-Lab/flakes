{ ... }:
{
  security.sudo.enable = true;
  # https://superuser.com/questions/500119
  security.sudo.extraConfig = "Defaults lecture = never";

  # https://nixos.wiki/wiki/Yubikey
  security.pam.yubico = {
    enable = true;
    mode = "challenge-response";

    # Default, pass or key.
    control = "sufficient";
  };
}
