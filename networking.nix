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

  services.samba.enable = true;
  services.samba.openFirewall = true;

  services.samba.shares = {
    "Music" = { public = "yes"; path = "/persistent/Music"; };
    "Videos" = { public = "yes"; path = "/persistent/Videos"; };
    "Public" = { public = "yes"; path = "/persistent/Public"; };
  };

  # https://github.com/Ninlives/emerge/blob/master/impl/lego/service/samba.nix
  services.samba.extraConfig = "map to guest = Bad User";

  services.samba-wsdd.enable = true;
  networking.firewall.allowedTCPPorts = [ 5357 ];
  networking.firewall.allowedUDPPorts = [ 3702 ];
}
