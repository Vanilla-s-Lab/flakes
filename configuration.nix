# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./users.nix

    ./hardware/bluetooth.nix
    ./hardware/nvidia.nix
    ./hardware/fileSystems.nix
    ./hardware/pulseaudio.nix

    ./networking.nix
    ./xserver.nix
    ./i18n.nix
    ./nix.nix

    ./services/openssh.nix
    ./services/fail2ban.nix
    ./services/udev.nix
    ./services/samba.nix
    ./services/btrfs.nix

    ./sops-config/pxder.nix
    ./sops-config/sg_cli.nix
    ./sops-config/ArchiSteamFarm.nix

    ./security.nix
    ./fixes.nix
    ./steam.nix
    ./virtualisation.nix
  ];

  environment.etc."nixos".source =
    "/persistent/Projects/flakes";

  # # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  # https://wiki.archlinux.org/title/sysctl
  boot.kernel.sysctl."kernel.sysrq" = 1;
  # https://nixos.wiki/wiki/NTFS
  boot.supportedFilesystems = [ "ntfs" ];
  # Required nvme kernel module to find disk.
  boot.initrd.availableKernelModules = [ "nvme" ];

  # Define your hostname.
  networking.hostName = "NixOS-RoT";
  networking.domain = "vanilla.local";

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows
  time.hardwareClockInLocalTime = true;

  # Use NetworkManager, persist WiFi connections.
  networking.networkmanager.enable = true;
  environment.etc."NetworkManager/system-connections".source =
    "/persistent/etc/NetworkManager/system-connections";

  # intel/ibt-17-16-1.sfi | rtl_nic/rtl8411-2.fw
  hardware.firmware = [ pkgsUnstable.linux-firmware ];

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
