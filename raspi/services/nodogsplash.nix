{ pkgs, ... }:
let nodogsplash = pkgs.callPackage ../../home-manager/packages/nodogsplash.nix { }; in
let customConfig = pkgs.runCommand "nodogsplash" { } ''
  mkdir -p $out/etc/
  cp ${nodogsplash}/etc/nodogsplash/nodogsplash.conf $out/etc/
  sed -i 's/br-lan/wlan0/g' $out/etc/nodogsplash.conf
''; in
{
  environment.etc."nodogsplash/nodogsplash.conf".source =
    "${customConfig}/etc/nodogsplash.conf";

  networking.firewall.allowedTCPPorts = [ 2050 ];
  networking.firewall.allowedUDPPorts = [ 2050 ];

  environment.etc."nodogsplash/htdocs".source =
    "${nodogsplash}/etc/nodogsplash/htdocs";

  systemd.services."nodogsplash" = {
    wantedBy = [ "multi-user.target" ];
    after = [ "dhcpd4.service" ];

    # -c ${customConfig}/etc/nodogsplash.conf
    script = "${nodogsplash}/bin/nodogsplash -f";
    path = with pkgs; [ iptables iproute2 ];
  };
}
