{ pkgs, config, inputs, system, ... }: with inputs;
let albert_quite = pkgs.albert.overrideAttrs (old: {
  # https://github.com/albertlauncher/albert/issues/758#issuecomment-509468503
  preFixup = "qtWrapperArgs+=(--set QT_LOGGING_RULES '*.debug=false;*.info=false')";
}); in

let pkgs_old = import inputs.nixpkgs-old
  { inherit system; }; in
{
  home.packages = [
    pkgs.qv2ray
    (pkgs.makeAutostartItem {
      name = "qv2ray";
      package = pkgs.qv2ray;
    })

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

  home.file.".config/qv2ray-vcore".source =
    pkgs.runCommand "vcore" { } ''
      mkdir $out/

      ln -s ${pkgs_old.v2ray}/bin/v2ray $out/v2ray
      ln -s ${pkgs_old.v2ray}/bin/v2ctl $out/v2ctl

      ln -s ${pkgs.v2ray-geoip}/share/v2ray/geoip.dat $out/geoip.dat
      ln -s ${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat $out/geosite.dat
    '';

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
