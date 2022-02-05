{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  # https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages =
    pkgs.linuxPackages_latest;

  # https://wiki.archlinux.org/title/sysctl
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  # https://nixos.wiki/wiki/NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  # Required nvme kernel module to find disk.
  boot.initrd.availableKernelModules = [ "nvme" ];
}
