{ ... }:
{
  # https://nixos.wiki/wiki/Samba#Samba_Server
  services.samba.enable = true;
  services.samba.openFirewall = true;

  # sudo smbpasswd -a vanilla
  services.samba.shares."Thunder" = {
    path = "/persistent/Downloads/Thunder";
    "read only" = "no";
  };

  services.samba-wsdd.enable = true;
  networking.firewall.allowedTCPPorts = [ 5357 ];
  networking.firewall.allowedUDPPorts = [ 3702 ];
}
