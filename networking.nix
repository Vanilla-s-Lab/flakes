{ pkgs, lib, config, ... }:
{
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users."vanilla".extraGroups = [ "wireshark" ];

  # networking.firewall.enable = false;
  networking.firewall.allowPing = false;

  networking.networkmanager.wifi.macAddress = "permanent";
  networking.networkmanager.wifi.scanRandMacAddress = true;

  # services/x11/desktop-managers/gnome.nix
  services.avahi.enable = false; # [ 5353 ]
  services.geoclue2.enable = false; # Deps

  # Qv2ray - Preferences - Inbound Settings
  # networking.firewall.allowedTCPPorts = [ 8889 ];

  # `python3 -m http.server` for file transfer.
  # networking.firewall.allowedTCPPorts = [ 8000 ];
}
