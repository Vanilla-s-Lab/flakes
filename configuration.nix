# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, system, ... }: with inputs;
{
  systemd.services."plymouth-quit".enable = false;

  programs.command-not-found.enable = true;
  programs.command-not-found.dbPath =
    "${nix-channel}/programs.sqlite";

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
    ./services/btrfs.nix
    ./services/smartdns.nix

    ./sops-config/sg_cli.nix
    ./sops-config/ArchiSteamFarm.nix
    ./sops-config/chaoxing.nix
    ./sops-config/openfortivpn.nix

    ./security.nix
    ./steam.nix
    ./virtualisation.nix

    ./systemd.nix
  ];

  environment.etc."nixos".source =
    "/persistent/Projects/flakes";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # https://bugzilla.kernel.org/show_bug.cgi?id=203637
  hardware.cpu.intel.updateMicrocode = true;

  # https://wiki.archlinux.org/title/sysctl
  boot.kernel.sysctl."kernel.sysrq" = 1;
  boot.kernel.sysctl."net.core.default_qdisc" = "fq";
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr2";
  # https://redis.io/docs/manual/admin/
  boot.kernel.sysctl."vm.overcommit_memory" = 1;
  # https://nixos.wiki/wiki/NTFS
  boot.supportedFilesystems = [ "ntfs" "apfs" ];
  # Required nvme kernel module to find disk.
  boot.initrd.availableKernelModules = [ "nvme" "tcp_bbr2" ];

  # https://wiki.archlinux.org/title/improving_performance#Watchdogs
  boot.kernelParams = [ "nowatchdog" ] # https://access.redhat.com/sites/default/files/attachments/201501-perf-brief-low-latency-tuning-rhel7-v2.1.pdf
    ++ [ "mce=ignore_ce" "nosoftlockup" "audit=0" /* SELinux */ "idle=poll" /* isolcpus= */ "skew_tick=1" "intel_pstate=disable" /* nohz_full= */ ];
  boot.blacklistedKernelModules = [ "iTCO_wdt" ];

  # Define your hostname.
  networking.hostName = "NixOS-RoT";
  networking.domain = "vanilla.local";

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Use NetworkManager, persist WiFi connections.
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.macAddress = "random";
  networking.networkmanager.ethernet.macAddress = "random";
  environment.etc."NetworkManager/system-connections".source =
    "/persistent/etc/NetworkManager/system-connections";

  # https://nixos.wiki/wiki/Encrypted_DNS#Setting_nameservers
  networking.networkmanager.insertNameservers = [ "127.0.0.1" /* "::1" */ ] ++
    [ "223.5.5.5" "223.6.6.6" ] ++ # https://alidns.com/knowledge?type=SETTING_DOCS#user_linux
    [ "119.29.29.29" ] ++ # https://docs.dnspod.cn/public-dns/public-dns-config-guide/
    [ "94.140.14.14" "94.140.15.15" ]; # https://kb.adguard.com/en/general/dns-providers#adguard-dns

  networking.resolvconf.enable = false;

  # intel/ibt-17-16-1.sfi | rtl_nic/rtl8411-2.fw
  hardware.firmware = [ pkgs.linux-firmware ];

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # nixos/modules/services/x11/desktop-managers/gnome.nix
  services.avahi.enable = false; # mkDefault true;

  # TODO: GDM / GNOME wayland on NVIDIA sync...?
  services.xserver.displayManager.gdm.wayland = false;

  # Disable most of GNOME bundled tools.
  services.gnome.core-utilities.enable = false;
  services.gnome.core-developer-tools.enable = false;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # services.printing.drivers = [ pkgs.hplip ];

  # /etc/cups -> /var/lib/cups
  systemd.tmpfiles.rules = [
    "L /var/lib/cups - - - - /persistent/var/lib/cups"
  ];

  security.rtkit.enable = true;

  # https://nixos.wiki/wiki/PipeWire
  hardware.pulseaudio.enable = false;
  services.pipewire.enable = true;

  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

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

  environment.etc."ansible/ansible.cfg".text = ''
    [defaults]
    interpreter_python = auto_silent
  '';

  environment.etc."ansible/hosts".text = ''
    [azure]
    root@20.24.195.187
  '';
}
