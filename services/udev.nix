{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Android
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
