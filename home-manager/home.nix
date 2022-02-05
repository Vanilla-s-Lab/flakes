{ pkgs, inputs, ... }:
{
  imports = [
    ./programs/chromium.nix
    ./programs/alacritty.nix
    ./programs/obs-studio.nix

    ./programs/sg_cli.nix
    ./config/sg_cli.nix
    "${inputs.Vanilla}/enableMangohud.nix"

    ./programs/github/git.nix
    ./programs/github/gpg.nix
    ./services/gpg-agent.nix
    ./programs/github/ssh.nix
    ./config/mr.nix
    "${inputs.Vanilla}/gitNixpkgs.nix"

    ./programs/autostart/qv2ray.nix
    ./programs/autostart/albert.nix
    ./programs/autostart/kotatogram.nix

    ./programs/fish.nix
    ./programs/wine-wechat.nix

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
    ./gnome/gedit.nix

    "${inputs.Vanilla}/gnomeNoWelcome.nix"
    "${inputs.Vanilla}/gnomeDefApps.nix"
    "${inputs.Vanilla}/gnomeEnableNumLock.nix"

    ./config/fcitx5.nix
    ./config/sops.nix
    ./config/pxder.nix
    ./config/ArchiSteamFarm.nix

    "${inputs.Vanilla}/persistHomeSsh.nix"
  ];

  home.packages = [ pkgs.nixpkgs-fmt ];
  home.stateVersion = "21.11";
}
