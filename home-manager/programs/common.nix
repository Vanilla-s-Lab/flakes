{ pkgs, ... }:
{
  home.packages = [
    pkgs.virt-manager
    pkgs.wpsoffice
  ];

  dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };
}
