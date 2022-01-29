{ pkgs, ... }:
{
  imports = [
    ./programs/chromium.nix
    ./programs/alacritty.nix
    ./programs/qv2ray.nix
    ./programs/git.nix
    ./programs/albert.nix

    ./dconf.nix
    ./file-links.nix
    ./fonts.nix
    ./gnome.nix
  ];

  home.packages = [ pkgs.nixpkgs-fmt ];
  home.stateVersion = "21.11";
}
