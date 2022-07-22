{ pkgs, inputs, lib, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;

  users.users."vanilla".extraGroups = [ "libvirtd" ]
    ++ [ "docker" ]; # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings =
    { fixed-cidr-v6 = "fd00::/80"; ipv6 = true; };

  systemd.tmpfiles.rules = [
    "L /var/lib/docker - - - - /persistent/var/lib/docker"
  ];

  # The default KVM virtual storage location.
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/libvirt" ];
  };

  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" "aarch64-linux" ];

  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;

  # https://nixos.wiki/wiki/VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
