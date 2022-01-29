{ pkgs, lib, ... }:
{
  # https://github.com/nix-community/home-manager/issues/1118
  fonts.fontconfig.enable = lib.mkForce true;

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
    pkgs.nur.repos.vanilla.Win10_LTSC_2021_fonts
    pkgs.nur.repos.vanilla.apple-fonts.SF-Compact
  ];
}
