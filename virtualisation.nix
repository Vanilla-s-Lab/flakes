{ pkgs, inputs, ... }:
let qemuOld = (import inputs.nixpkgs-old
  { system = "x86_64-linux"; }).pkgs.qemu; in
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = qemuOld;

  users.users."vanilla".extraGroups = [ "libvirtd" ]
    ++ [ "docker" ]; # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;

  systemd.tmpfiles.rules = [
    "L /var/lib/docker - - - - /persistent/var/lib/docker"
  ];

  # The default KVM virtual storage location.
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/libvirt" ];
  };

  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" ];

  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;

  # https://nixos.wiki/wiki/VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "vanilla" ];
}
