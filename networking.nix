{ pkgs, ... }:
{
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 1089 8889 ];
  # networking.firewall.allowedUDPPorts = [ 1089 8889 ];

  # https://userbase.kde.org/KDEConnect#Troubleshooting
  networking.firewall.allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 1714; to = 1764; }];

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users."vanilla".extraGroups = [ "wireshark" ];

  networking.firewall.allowPing = false;
  # https://www.garron.me/en/bits/iptables-open-port-for-specific-ip.html
  networking.firewall.extraCommands = ''
    iptables -A INPUT -p tcp -s 192.168.49.2 --dport 8889 -j ACCEPT
    iptables -A OUTPUT -p tcp -d 192.168.49.2 --dport 8889 -j ACCEPT
  '';
}
