{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  users.users."vanilla".extraGroups = [ "libvirtd" ];
}
