{ pkgs, inputs, ... }: with inputs;
let pkgs_nixpkgs-fmt = pkgs.callPackage "${nixpkgs-old}/pkgs/tools/nix/nixpkgs-fmt" { }; in
{
  imports = [
    ./programs/browsers.nix
    ./programs/terminal.nix

    ./programs/github.nix

    ./programs/autostart.nix
    ./programs/common.nix
    ./programs/develop.nix
    ./programs/neovim.nix

    ./file-links.nix
    ./fonts.nix

    ./gnome/extensions.nix
    ./gnome/tweaks.nix
    ./gnome/system-monitor.nix
    ./gnome/settings.nix
    ./gnome/desktop.nix
    ./gnome/common.nix
    ./gnome/dconf.nix
    ./gnome/mimeApps.nix

    ./config/fcitx5.nix
    ./config/ArchiSteamFarm.nix
  ];

  home.packages = [
    pkgs_nixpkgs-fmt
    pkgs.sops
  ];

  home.enableDebugInfo = true;
  home.stateVersion = "22.11";
}
