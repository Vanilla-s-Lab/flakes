{ pkgs, lib, config, ... }:
{
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users."vanilla".extraGroups = [ "wireshark" ];

  # networking.firewall.enable = false;
  networking.firewall.allowPing = false;

  networking.networkmanager.wifi.macAddress = "permanent";
  networking.networkmanager.wifi.scanRandMacAddress = true;

  networking.interfaces."wlp0s20f3".ipv4.routes = (lib.singleton
    { address = "10.0.100.204"; prefixLength = 32; via = "192.168.5.1"; });
}
