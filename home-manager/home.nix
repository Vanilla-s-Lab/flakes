{ pkgs, inputs, ... }:
{
  imports = [
    ./programs/chromium.nix
    ./programs/alacritty.nix
    ./programs/obs-studio.nix
    ./programs/adb.nix

    ./programs/sg_cli.nix
    ./config/sg_cli.nix
    "${inputs.Vanilla}/enableMangohud.nix"

    ./programs/git.nix
    ./config/mr.nix
    "${inputs.Vanilla}/gitNixpkgs.nix"

    ./programs/autostart/qv2ray.nix
    ./programs/autostart/albert.nix
    ./programs/autostart/kotatogram.nix

    ./programs/shell/fish.nix
    ./programs/shell/starship.nix
    ./programs/shell/exa.nix

    ./programs/gpg.nix
    ./services/gpg-agent.nix
    ./programs/ssh.nix

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
