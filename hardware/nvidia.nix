{ inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  imports = [
    "${inputs.Vanilla}/fixHDMI.nix"
    "${inputs.Vanilla}/earlyKMS.nix"
  ];
}
