{ ... }:
{
  imports = [
    ./bluetooth/default.nix
    ./nvidia/default.nix
    ./microcode/default.nix
    ./fileSystems/default.nix
    ./kernelModules/default.nix
    ./bindMount/default.nix
  ];
}
