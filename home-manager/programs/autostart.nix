{ pkgs, config, inputs, ... }:
let
  albert_quite = pkgs.albert.overrideAttrs (old: {
    # https://github.com/albertlauncher/albert/issues/758#issuecomment-509468503
    preFixup = "qtWrapperArgs+=(--set QT_LOGGING_RULES '*.debug=false;*.info=false')";
  });
in

let pkgs_QvPlugin-Trojan = pkgs.callPackage ../packages/QvPlugin-Trojan.nix { }; in
let pkgs_qv2ray = pkgs.libsForQt5.callPackage "${inputs.nixos-unstable}/pkgs/applications/networking/qv2ray" { }; in
{
  home.packages = [
    pkgs_qv2ray
    (pkgs.makeAutostartItem {
      name = "qv2ray";
      package = pkgs_qv2ray;
    })

    pkgs_QvPlugin-Trojan

    pkgs.v2ray
    pkgs.v2ray.assetsDrv

    albert_quite
    (pkgs.makeAutostartItem {
      name = "albert";
      package = albert_quite;
    })

    pkgs.kotatogram-desktop
    (pkgs.makeAutostartItem {
      name = "kotatogramdesktop";
      package = pkgs.kotatogram-desktop;
    })

    pkgs.nur.repos.linyinfeng.clash-for-windows
    (pkgs.makeAutostartItem {
      name = "clash-for-windows";
      package = pkgs.nur.repos.linyinfeng.clash-for-windows;
    })
  ];

  home.file.".config/qv2ray".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/qv2ray";

  home.file.".config/albert".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/albert";

  home.file.".local/share/KotatogramDesktop".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/KotatogramDesktop";

  home.file.".config/clash".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/clash";

  home.file.".config/clash_win".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/clash_win";
}
