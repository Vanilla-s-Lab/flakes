{ pkgs, ... }:
let firewallIO = { ip, port }: ''
  iptables -A INPUT -p tcp -s ${ip} --dport ${builtins.toString port} -j ACCEPT
  iptables -A OUTPUT -p tcp -d ${ip} --dport ${builtins.toString port} -j ACCEPT
''; in
{
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 1089 8889 ];
  # networking.firewall.allowedUDPPorts = [ 1089 8889 ];

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users."vanilla".extraGroups = [ "wireshark" ];

  networking.firewall.allowPing = false;
  # https://www.garron.me/en/bits/iptables-open-port-for-specific-ip.html
  networking.firewall.extraCommands = ''
    ${firewallIO { ip = "192.168.49.2"; port = 8889; }}
    ${firewallIO { ip = "192.168.49.3"; port = 8889; }}
    ${firewallIO { ip = "192.168.49.4"; port = 8889; }}
  '';

  # networking.firewall.enable = false;
  networking.firewall.checkReversePath = "loose";
}
