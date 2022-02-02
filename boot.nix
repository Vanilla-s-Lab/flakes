{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  # https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages =
    pkgs.linuxPackages_xanmod;

  # https://wiki.archlinux.org/title/sysctl
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  # https://nixos.wiki/wiki/NTFS
  boot.supportedFilesystems = [ "ntfs" ];
}
