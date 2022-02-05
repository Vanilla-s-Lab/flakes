{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.qv2ray
    (pkgs.makeAutostartItem {
      name = "qv2ray";
      package = pkgs.qv2ray;
    })
  ];

  home.file.".config/qv2ray-vcore".source = with pkgs;
    runCommand "vcore" { } ''mkdir $out/ && \
      ln -s ${v2ray}/bin/v2ray $out/v2ray && ln -s ${v2ray}/bin/v2ctl $out/v2ctl
      ln -s ${v2ray-geoip}/share/v2ray/geoip.dat $out/geoip.dat
      ln -s ${v2ray-domain-list-community}/share/v2ray/geosite.dat $out/geosite.dat
    '';

  home.file.".config/qv2ray".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/qv2ray";
}
