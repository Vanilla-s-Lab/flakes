{ pkgs, inputs, ... }:
{
  imports = [
    ./programs/chromium.nix
    ./programs/terminal.nix
    ./programs/obs-studio.nix

    "${inputs.Vanilla}/enableMangohud.nix"

    ./programs/github.nix
    ./config/mr.nix

    ./programs/autostart.nix
    ./programs/common.nix

    ./file-links.nix
    ./fonts.nix

    ./gnome/extensions.nix
    ./gnome/tweaks.nix
    ./gnome/system-monitor.nix
    ./gnome/folders.nix
    ./gnome/settings.nix
    ./gnome/dockIcons.nix

    ./gnome/nautilus.nix
    ./gnome/gedit.nix

    "${inputs.Vanilla}/gnomeNoWelcome.nix"
    "${inputs.Vanilla}/gnomeDefApps.nix"
    "${inputs.Vanilla}/gnomeEnableNumLock.nix"

    ./config/fcitx5.nix
    ./config/sops.nix
    ./config/pxder.nix
    ./config/sg_cli.nix
    ./config/ArchiSteamFarm.nix

    "${inputs.Vanilla}/persistHomeSsh.nix"
  ];

  home.packages = [ pkgs.nixpkgs-fmt ];
  home.stateVersion = "21.11";
}
