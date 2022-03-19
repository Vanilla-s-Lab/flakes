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

  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;

  # https://doc.traefik.io/traefik/getting-started/quick-start/
  virtualisation.podman.dockerSocket.enable = true;
  users.extraGroups."podman".members = [ "vanilla" ];

  # https://nixos.wiki/wiki/VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "vanilla" ];
}
