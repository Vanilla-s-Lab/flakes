{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  users.users."vanilla".extraGroups = [ "libvirtd" ];

  # The default KVM virtual storage location.
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/libvirt" ];
  };
}
