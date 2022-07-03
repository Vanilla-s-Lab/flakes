{ config, pkgs, lib, inputs, ... }: with inputs;
{
  # https://nixos.wiki/wiki/FAQ
  nixpkgs.config.allowUnfree = true;

  # https://github.com/NixOS/nixpkgs/pull/172660#issuecomment-1159465063=
  disabledModules = [ "hardware/video/nvidia.nix" "services/hardware/udev.nix" ];
  imports = [ "${nixpkgs-unstable}/nixos/modules/hardware/video/nvidia.nix" ]
    ++ [ "${nixpkgs-udev-fix}/nixos/modules/services/hardware/udev.nix" ];

  # https://github.com/NixOS/nixpkgs/pull/172660#issuecomment-1124584578=
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.open = true; # We finally packaged `nvidia-open` by @NickCao!

  # https://nixos.wiki/wiki/Nvidia
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Remove NVIDIA X Server Settings app.
  hardware.nvidia.nvidiaSettings = false;

  # https://nixos.wiki/wiki/Nvidia#sync_mode
  hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  # Credit: @mlatus
  # Fix black screen issues of HDMI / DP port.
  services.xserver.displayManager.sessionCommands =
    config.services.xserver.displayManager.setupCommands;

  # https://wiki.archlinux.org/title/kernel_mode_setting#Early_KMS_start
  boot.initrd = {
    enable = true;
    kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  };

  # https://nixos.wiki/wiki/OpenGL
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [ mesa.drivers ]
    ++ [ intel-media-driver vaapiIntel vaapiVdpau libvdpau-va-gl ];
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel ];
}
