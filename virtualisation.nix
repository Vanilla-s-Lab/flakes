{ pkgs, inputs, lib, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;

  users.users."vanilla".extraGroups = [ "libvirtd" ]
    ++ [ "docker" ]; # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;

  # https://docs.docker.com/build/buildkit/
  virtualisation.docker.daemon.settings = {
    "features" = { "buildkit" = true; };
  };

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
  users.extraGroups.vboxusers.members = [ "vanilla" ];
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  environment.systemPackages = [
    (pkgs.callPackage ./home-manager/packages/docker-lock.nix { })
  ];

  virtualisation.libvirtd.qemu.ovmf.enable = true;
  virtualisation.libvirtd.qemu.ovmf.packages =
    (lib.singleton pkgs.OVMFFull);
}
