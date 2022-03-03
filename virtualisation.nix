{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  users.users."vanilla".extraGroups = [ "libvirtd" ];

  # The default KVM virtual storage location.
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/libvirt" ];
  };

  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" ];

} // {

  # https://github.com/k3d-io/k3d/issues/84
  virtualisation.docker.enable = true;
  users.users."vanilla".extraGroups = [ "docker" ];
}
