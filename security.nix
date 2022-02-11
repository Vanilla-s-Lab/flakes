{ lib, pkgs, ... }:
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

  # https://unix.stackexchange.com/questions/68897
  security.sudo.extraRules = lib.singleton {
    # https://askubuntu.com/questions/166809/how-can-i-disable-my-webcam
    commands = lib.singleton {
      command = "/run/current-system/sw/bin/tee" + " " +
        "/sys/bus/usb/devices/1-8/bConfigurationValue";
      options = [ "NOPASSWD" ];
    };

    # https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file
    users = lib.singleton "vanilla";
  };
}
