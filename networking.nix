{ pkgs, lib, config, ... }:
{
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users."vanilla".extraGroups = [ "wireshark" ];

  # networking.firewall.enable = false;
  networking.firewall.allowPing = false;

  networking.networkmanager.wifi.macAddress = "permanent";
  networking.networkmanager.wifi.scanRandMacAddress = true;

  services.smokeping.enable = true;
  services.smokeping.targetConfig = ''
    probe = FPing
    menu = Default
    title = Default

    + TWX
    menu = TWX
    title = TWX

    ++ Baidu
    host = baidu.com
    ++ JumpServer
    host = 10.0.100.204
    ++ Sina
    host = sina.com.cn
    ++ Moka
    host = mokahr.com
  '';

  # services/x11/desktop-managers/gnome.nix
  services.avahi.enable = false; # [ 5353 ]
}
