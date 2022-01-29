{ pkgs, lib, ... }:
{
  # https://github.com/nix-community/home-manager/issues/1118
  fonts.fontconfig.enable = lib.mkForce true;

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
  ];
}
