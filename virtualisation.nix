{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  users.users."vanilla".extraGroups = [ "libvirtd" ]
    ++ [ "docker" ]; # GitHub - k3d-io/k3d - #84
  virtualisation.docker.enable = true;

  # The default KVM virtual storage location.
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/libvirt" ];
  };

  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" ];

  systemd.tmpfiles.rules = [
    "L /var/lib/docker - - - - /persistent/var/lib/docker"
  ];
}
