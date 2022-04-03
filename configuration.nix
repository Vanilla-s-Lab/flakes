# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:
{
  networking.firewall.allowedTCPPorts = [ 8000 ];
  networking.firewall.allowedUDPPorts = [ 8000 ];

  programs.java.enable = true;
  programs.java.package = pkgs.jdk17_headless;

  imports = [
    ./users.nix

    ./hardware/bluetooth.nix
    ./hardware/nvidia.nix
    ./hardware/fileSystems.nix

    ./networking.nix
    ./nix.nix

    ./services/openssh.nix
    ./services/fail2ban.nix
    ./services/udev.nix
    ./services/samba.nix
    ./services/btrfs.nix

    ./sops-config/pxder.nix
    ./sops-config/sg_cli.nix
    ./sops-config/ArchiSteamFarm.nix
    ./sops-config/certificate-pem.nix
    ./sops-config/chaoxing.nix

    ./security.nix
    ./steam.nix
    ./virtualisation.nix
  ];

  environment.etc."nixos".source =
    "/persistent/Projects/flakes";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  # https://bugzilla.kernel.org/show_bug.cgi?id=203637
  hardware.cpu.intel.updateMicrocode = true;

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

  # Use NetworkManager, persist WiFi connections.
  networking.networkmanager.enable = true;
  environment.etc."NetworkManager/system-connections".source =
    "/persistent/etc/NetworkManager/system-connections";

  # intel/ibt-17-16-1.sfi | rtl_nic/rtl8411-2.fw
  hardware.firmware = [ pkgs.linux-firmware ];

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain" + ","
    # https://minikube.sigs.k8s.io/docs/handbook/vpn_and_proxy/
    + "localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.39.0/24";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = { keyMap = "us"; };

  # Enable fcitx5 with chinese addons.
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [
    pkgs.fcitx5-chinese-addons
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # TODO: GDM / GNOME wayland on NVIDIA sync...?
  services.xserver.displayManager.gdm.wayland = false;

  # Disable most of GNOME bundled tools.
  services.gnome.core-utilities.enable = false;
  services.gnome.core-developer-tools.enable = false;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # /etc/cups -> /var/lib/cups
  systemd.tmpfiles.rules = [
    "L /var/lib/cups - - - - /persistent/var/lib/cups"
  ];

  # https://nixos.wiki/wiki/PipeWire#Enabling_PipeWire
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;

  # amixer sset 'Master' 35%
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;

  # nixos/modules/services/x11/desktop-managers/gnome.nix
  hardware.pulseaudio.enable = false; # mkDefault true;

  # https://github.com/NixOS/nixpkgs/pull/165125#issuecomment-1074650829=
  systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  # https://github.com/rofl0r/proxychains-ng
  environment.etc."proxychains.conf".text = ''
    [ProxyList]
    socks5 127.0.0.1 1080
  '';
}
