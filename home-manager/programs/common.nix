{ inputs, system, pkgs, config, generated, ... }:
{
  home.packages = with inputs; [
    pkgs.nur.repos.xddxdd.wine-wechat
    pkgs.obs-studio
    pkgs.nur.repos.linyinfeng.wemeet

    # ls[usb|pci].
    pkgs.pciutils
    pkgs.usbutils

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

  home.file.".config/obs-studio".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/obs-studio";

  home.file.".local/share/wine-wechat".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/wine-wechat";

  # https://github.com/flightlessmango/MangoHud
  programs.mangohud.enable = true;
  # programs.mangohud.enableSessionWide = true;
}
