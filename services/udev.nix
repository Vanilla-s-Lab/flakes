{ pkgs, ... }:
let brightness = "/sys/class/backlight/intel_backlight/brightness"; in
{
  # https://nixos.wiki/wiki/Android
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # https://wiki.archlinux.org/title/backlight
  users.groups."video".members = [ "vanilla" ];
  services.udev.extraRules = ''
    RUN+="${pkgs.coreutils}/bin/chgrp video ${brightness}"
    RUN+="${pkgs.coreutils}/bin/chmod g+w ${brightness}"
  '';
}
