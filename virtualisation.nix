{ pkgs, inputs, lib, ... }:
{
  # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;
  users.users."vanilla".extraGroups = [ "docker" ];

  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" "aarch64-linux" ]
    ++ [ "riscv32-linux" "riscv64-linux" ];
}
