{ inputs, system, pkgs, config, ... }:
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

    pkgs.scrcpy

    pkgs.playonlinux

    # https://github.com/dyweb/Deedy-Resume-for-Chinese
    pkgs.texlive.combined.scheme-full

    pkgs.unzip
    pkgs.p7zip

    # https://github.com/msojocs/bilibili-linux
    (pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.icu ];
    })

    # https://github.com/VergeDX/config-nixpkgs/commit/a01f0549903df3d6b18602ed7e1554a79d215913
    (pkgs.runCommandLocal "Discord" { nativeBuildInputs = [ pkgs.makeWrapper ]; }
      ''
        mkdir -p $out
        ${pkgs.xorg.lndir}/bin/lndir -silent ${pkgs.discord} $out
        wrapProgram $out/opt/Discord/Discord \
          --add-flags '--proxy-server=http://127.0.0.1:8889'
      '')

    pkgs.betterdiscordctl
  ];

  home.file.".config/discord".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/discord";

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

    [UnixUpdateInfo]
    UserRejectUpdateVersion=11.1.0.10976
  '';

  home.file.".local/share/Kingsoft/office6/skins/default/histroy.ini".text = ''
    [wpsoffice]
    lastSkin=2019white
  '';
}
