{ inputs, system, pkgs, config, ... }:
let pkgs_hwatch = pkgs.callPackage ../packages/hwatch { }; in
{
  home.packages = with inputs; [
    nixos-cn.legacyPackages."${system}".wine-wechat
    pkgs.obs-studio
    pkgs.virt-manager
    pkgs.wpsoffice

    pkgs.nur.repos.linyinfeng.wemeet

    # ls[usb|pci].
    pkgs.pciutils
    pkgs.usbutils

    pkgs.cawbird

    pkgs.playonlinux

    pkgs.alsa-utils

    # https://github.com/dyweb/Deedy-Resume-for-Chinese
    pkgs.texlive.combined.scheme-full

    pkgs.osu-lazer

    pkgs.unzip
    pkgs.p7zip

    pkgs_hwatch
  ];

  home.file.".local/share/osu".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/osu";

  home.file.".PlayOnLinux".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/PlayOnLinux";

  home.file.".config/obs-studio".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/obs-studio";

  home.file.".local/lib/wine-wechat".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/lib/wine-wechat";

  # https://github.com/flightlessmango/MangoHud
  programs.mangohud.enable = true;
  # programs.mangohud.enableSessionWide = true;

  # https://nixos.wiki/wiki/Virt-manager
  dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };

  home.file.".config/cawbird".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/cawbird";

  dconf.settings."uk.co.ibboard.cawbird" = {
    hide-nsfw-content = false;
    startup-accounts = [ "osu_Vanilla" ];
  };

  home.file.".config/Kingsoft/Office.conf".text = ''
    [6.0]
    common\AcceptedEULA=true
    plugins\kstartpage\redpoint_skincenter=false
    common\system_check\no_necessary_symbol_fonts=false

    [UnixUpdateInfo]
    UserRejectUpdateVersion=11.1.0.10976
  '';

  home.file.".local/share/Kingsoft/office6/skins/default/histroy.ini".text = ''
    [wpsoffice]
    lastSkin=2019white
  '';
}
