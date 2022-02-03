{ ... }:
{
  # https://nixos.wiki/wiki/Yubikey
  security.pam.yubico = {
    enable = true;
    mode = "challenge-response";

    # Default, pass or key.
    control = "sufficient";
  };
}
