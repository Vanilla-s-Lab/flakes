{ pkgs, config, inputs, ... }:
{
  home.packages = [
    pkgs.qv2ray
    (pkgs.makeAutostartItem {
      name = "qv2ray";
      package = pkgs.qv2ray;
    })

    pkgs.albert
    (pkgs.makeAutostartItem {
      name = "albert";
      package = pkgs.albert;
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
    pkgs.runCommand "vcore" { } ''mkdir $out/ && \
      ln -s ${pkgs.v2ray}/bin/v2ray $out/v2ray && ln -s ${pkgs.v2ray}/bin/v2ctl $out/v2ctl
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

  home.activation."how-can-i-disable-my-webcam" = ''
    echo 0 | sudo /run/current-system/sw/bin/tee \
      /sys/bus/usb/devices/1-8/bConfigurationValue \
      > /dev/null || true
  '';

  home.file.".config/clash".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/clash";

  home.file.".config/clash_win".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/clash_win";
}
