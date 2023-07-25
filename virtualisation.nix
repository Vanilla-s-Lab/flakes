{ pkgs, inputs, lib, ... }:
{
  # https://nixos.wiki/wiki/Podman
  users.users."vanilla".extraGroups =
    [ "podman" /* "docker" */ ];

  # https://nixos.wiki/wiki/Docker
  # virtualisation.docker.enable = true;

  # https://docs.docker.com/build/buildkit/
  virtualisation.docker.daemon.settings = {
    "features" = { "buildkit" = true; };
  };

  systemd.tmpfiles.rules = [
    "L /var/lib/docker - - - - /persistent/var/lib/docker"
  ];

  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" "aarch64-linux" ]
    ++ [ "riscv32-linux" "riscv64-linux" ];

  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerSocket.enable = true;

  environment.systemPackages = [
    (pkgs.callPackage ./home-manager/packages/docker-lock.nix { })
  ];
}
