{ pkgs, inputs, ... }:
let chinalist = pkgs.callPackage
  ''${inputs."icebox-nix/netkit.nix"}/pkgs/data/chinalist/''
  { format = "smartdns"; server = ""; }; in
{
  services.smartdns.enable = true;
  services.smartdns.settings = {
    server = [ "114.114.114.114" "114.114.115.115" ];

    conf-file = [
      "${chinalist}/accelerated-domains.china.smartdns.conf"
      "${chinalist}/apple.china.smartdns.conf"
      "${chinalist}/google.china.smartdns.conf"
    ];
  };

  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
