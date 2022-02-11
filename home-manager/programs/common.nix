{ inputs, system, pkgs, config, ... }:
{
  home.packages = with inputs; [
    nixos-cn.legacyPackages."${system}".wine-wechat
    pkgs.obs-studio
    pkgs.virt-manager
    pkgs.wpsoffice
    pkgs.nur.repos.linyinfeng.wemeet
  ];

  home.file.".config/obs-studio".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/obs-studio";

  home.file.".local/lib/wine-wechat".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/lib/wine-wechat";

  # https://github.com/flightlessmango/MangoHud
  programs.mangohud.enable = true;
  programs.mangohud.enableSessionWide = true;

  # https://nixos.wiki/wiki/Virt-manager
  dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };

  home.file.".local/share/wemeetapp".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/wemeetapp";
}
