{ pkgs, inputs, ... }:
{
  imports = [
    ./programs/browsers.nix
    ./programs/terminal.nix

    ./programs/github.nix

    ./programs/autostart.nix
    ./programs/common.nix
    ./programs/develop.nix

    ./file-links.nix
    ./fonts.nix

    ./gnome/extensions.nix
    ./gnome/tweaks.nix
    ./gnome/system-monitor.nix
    ./gnome/settings.nix
    ./gnome/desktop.nix
    ./gnome/common.nix

    "${inputs.Vanilla}/gnomeNoWelcome.nix"
    "${inputs.Vanilla}/gnomeEnableNumLock.nix"

    ./config/fcitx5.nix
    ./config/sops.nix
    ./config/pxder.nix
    ./config/sg_cli.nix
    ./config/ArchiSteamFarm.nix
    ./config/access_tokens.nix

    "${inputs.Vanilla}/persistHomeSsh.nix"
  ];

  home.packages = [ pkgs.nixpkgs-fmt ];
  home.stateVersion = "21.11";
}
