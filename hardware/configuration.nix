{ inputs, ... }:
{
  imports = [ "${inputs.Vanilla}/allMicrocode.nix" ];
  boot.initrd.availableKernelModules = [ "nvme" ];
}
