{ ... }:
{
  boot.initrd.enable = true;
  boot.initrd.kernelModules =
    [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
}
