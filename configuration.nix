# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./boot.nix
    ./time.nix
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

    ./security/sudo.nix
    ./security/yubico.nix

    ./fixes.nix
    ./steam.nix
    ./virtualisation.nix
  ];

  environment.etc."nixos".source =
    "/persistent/Projects/flakes";

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
