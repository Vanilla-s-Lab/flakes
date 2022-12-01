{ pkgs, config, ... }:
let albert_quite = pkgs.albert.overrideAttrs (old: {
  # https://github.com/albertlauncher/albert/issues/758#issuecomment-509468503
  preFixup = "qtWrapperArgs+=(--set QT_LOGGING_RULES '*.debug=false;*.info=false')";
}); in
{
  home.packages = [
    pkgs.qv2ray
    (pkgs.makeAutostartItem {
      name = "qv2ray";
      package = pkgs.qv2ray;
    })

    pkgs.xray.assetsDrv
    (pkgs.xray.overrideAttrs (old: {
      postFixup = "";
    }))

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
