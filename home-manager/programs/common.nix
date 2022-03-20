{ inputs, system, pkgs, pkgsUnstable, config, ... }:
{
  home.packages = with inputs; [
    nixos-cn.legacyPackages."${system}".wine-wechat
    pkgs.obs-studio
    pkgs.virt-manager
    pkgs.wpsoffice

    ((pkgs.nur.repos.linyinfeng.wemeet.overrideAttrs
      (old: { meta = { }; })).override {
      makeDesktopItem = pkgsUnstable.makeDesktopItem;
    })

    # ls[usb|pci].
    pkgs.pciutils
    pkgs.usbutils

    pkgs.cawbird

    pkgs.playonlinux

    (pkgs.nur.repos.xddxdd.dingtalk.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [ pkgs.krb5 ];
    }))
    # nixos-cn.legacyPackages."${system}".dingtalk
  ];

  home.file.".config/DingTalk".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/DingTalk";

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
    UserRejectUpdateVersion=11.1.0.10920
  '';

  home.file.".local/share/Kingsoft/office6/skins/default/histroy.ini".text = ''
    [wpsoffice]
    lastSkin=2019white
  '';
}
