{ pkgs, config, inputs, ... }:
let
  albert_quite = pkgs.albert.overrideAttrs (old: {
    # https://github.com/albertlauncher/albert/issues/758#issuecomment-509468503
    preFixup = "qtWrapperArgs+=(--set QT_LOGGING_RULES '*.debug=false;*.info=false')";
  });
in
{
  home.packages = [
    pkgs.qv2ray
    (pkgs.makeAutostartItem {
      name = "qv2ray";
      package = pkgs.qv2ray;
    })

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
  ];

  home.file.".config/qv2ray".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/qv2ray";

  home.file.".config/albert".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/albert";

  home.file.".config/albert.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/albert.conf";

  home.file.".local/share/KotatogramDesktop".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/KotatogramDesktop";
}
