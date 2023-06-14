{ inputs, system, pkgs, config, generated, ... }:
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

    pkgs.playonlinux

    # https://github.com/dyweb/Deedy-Resume-for-Chinese
    pkgs.texlive.combined.scheme-full

    pkgs.zip
    pkgs.unzip
    pkgs.p7zip

    # https://github.com/msojocs/bilibili-linux
    (pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.icu ]
        ++ [ pkgs.libsecret ];
    })

    pkgs.unrar
    pkgs.nodePackages.pxder
  ];

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

  home.file.".config/Kingsoft/Office.conf".text = ''
    [6.0]
    common\AcceptedEULA=true
    plugins\kstartpage\redpoint_skincenter=false
    common\system_check\no_necessary_symbol_fonts=false
    common\do_not_detect_file_association_while_startup=true

    [UnixUpdateInfo]
    UserRejectUpdateVersion=11.1.0.11664
  '';

  home.file.".local/share/Kingsoft/office6/skins/default/histroy.ini".text = ''
    [wpsoffice]
    lastSkin=2019white
  '';
}
