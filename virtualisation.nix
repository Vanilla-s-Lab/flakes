{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  users.users."vanilla".extraGroups = [ "libvirtd" ];

  # The default KVM virtual storage location.
  fileSystems."/var/lib/libvirt" = {
    device = "/persistent/var/lib/libvirt";
    options = [ "bind" ];
  };
}
