{ pkgs, ... }:
{
  imports = [
    ./programs/chromium.nix
    ./programs/alacritty.nix
    ./programs/qv2ray.nix
    ./programs/git.nix
    ./programs/albert.nix
    ./programs/kotatogram.nix

    ./programs/fish.nix
    ./programs/starship.nix

    ./programs/gpg.nix
    ./services/gpg-agent.nix
    ./programs/ssh.nix

    ./dconf.nix
    ./file-links.nix
    ./fonts.nix

    ./gnome/tweaks.nix
    ./gnome/system-monitor.nix

    ./config/fcitx5.nix
    ./config/ssh.nix
    ./config/sops.nix
  ];

  home.packages = [ pkgs.nixpkgs-fmt ];
  home.stateVersion = "21.11";
}
