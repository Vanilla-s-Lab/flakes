{ pkgs, inputs, lib, ... }:
{
  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" "aarch64-linux" ]
    ++ [ "riscv32-linux" "riscv64-linux" ];
}
