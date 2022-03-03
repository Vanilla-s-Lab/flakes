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

  # https://docs.hercules-ci.com/arion/#_nixos
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;
  users.extraUsers."vanilla".extraGroups = [ "podman" ];
}
