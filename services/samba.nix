{ ... }:
{
  # https://nixos.wiki/wiki/Samba#Samba_Server
  services.samba.enable = true;

  # sudo smbpasswd -a vanilla
  services.samba.shares."Thunder" = {
    path = "/persistent/Downloads/Thunder";
    "read only" = "no";
  };
}
