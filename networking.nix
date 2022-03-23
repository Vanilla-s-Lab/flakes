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
}
