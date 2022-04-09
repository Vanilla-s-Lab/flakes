{ pkgs, ... }:
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
    iptables -A INPUT -p tcp -m iprange --src-range 192.168.49.2-192.168.49.4 --dport 8889 -j ACCEPT
    iptables -A OUTPUT -p tcp -m iprange --src-range 192.168.49.2-192.168.49.4 --dport 8889 -j ACCEPT
  '';

  # networking.firewall.enable = false;
  networking.firewall.checkReversePath = "loose";
}
