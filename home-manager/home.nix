{ pkgs, inputs, ... }:
{
  imports = [
    ./programs/chromium.nix
    ./programs/alacritty.nix
    ./programs/git.nix

    ./programs/qv2ray.nix
    ./programs/albert.nix
    ./programs/kotatogram.nix

    ./programs/fish.nix
    ./programs/starship.nix

    ./programs/gpg.nix
    ./services/gpg-agent.nix
    ./programs/ssh.nix

    ./programs/exa.nix

    ./file-links.nix
    ./fonts.nix

    ./gnome/bundled-ext.nix
    ./gnome/extenal-ext.nix
    ./gnome/tweaks.nix
    ./gnome/system-monitor.nix
    ./gnome/folders.nix
    ./gnome/settings.nix
    ./gnome/dockIcons.nix
    ./gnome/nautilus.nix

    "${inputs.Vanilla}/gnomeNoWelcome.nix"
    "${inputs.Vanilla}/gnomeDefApps.nix"
    "${inputs.Vanilla}/gnomeEnableNumLock.nix"

    ./config/fcitx5.nix
    ./config/sops.nix
    ./config/pxder.nix
    ./config/mr.nix

    "${inputs.Vanilla}/persistHomeSsh.nix"
  ];

  home.packages = [ pkgs.nixpkgs-fmt ];
  home.stateVersion = "21.11";
}
