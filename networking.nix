{ pkgs, lib, config, ... }:
let mkPublic = folders: (builtins.listToAttrs
  (pkgs.lib.lists.forEach folders (x: {
    name = "${x}";
    value = {
      public = "yes";
      path = "/persistent/${x}";

      # https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html
      "dfree command" = (pkgs.writeTextFile {
        name = "junk";

        text = ''
          #! /bin/sh

          echo "${builtins.toString (514 * 1024 * 1024)} ${builtins.toString (114 * 1024 * 1024)}"
        '';

        executable = true;
      });
    };
  }))); in
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

  services.samba.shares = (mkPublic
    [ "Music" "Videos" "Public" ]);

  # https://github.com/Ninlives/emerge/blob/master/impl/lego/service/samba.nix
  services.samba.extraConfig = "map to guest = Bad User";

  services.samba-wsdd.enable = true;
  networking.firewall.allowedTCPPorts = [ 5357 ];
  networking.firewall.allowedUDPPorts = [ 3702 ];
}
