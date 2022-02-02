# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware/bind-mount.nix

    ./hardware/default.nix

    "${inputs.Vanilla}/pulseAudioAptX.nix"

    ./users.nix
    { boot.loader.systemd-boot.enable = true; }
    "${inputs.Vanilla}/xanmodKernel.nix"
    "${inputs.Vanilla}/enableSysRq.nix"
    "${inputs.Vanilla}/supportNTFS.nix"

    { time.timeZone = "Asia/Shanghai"; }
    "${inputs.Vanilla}/dualBootWindows.nix"

    ./networking/hostName-domain.nix
    ./networking/networkmanager.nix
    ./networking/proxy.nix

    ./xserver.nix

    "${inputs.Vanilla}/fcitx5Chinese.nix"
    "${inputs.Vanilla}/enLocalMap.nix"

    "${inputs.Vanilla}/nixFlakes.nix"
    { programs.git.enable = true; }
    "${inputs.Vanilla}/nixOfficialCache.nix"
    "${inputs.Vanilla}/nixIlyaFedinCache.nix"

    "${inputs.Vanilla}/useOpenSSH.nix"
    "${inputs.Vanilla}/useFail2ban.nix"

    "${inputs.Vanilla}/persistEtcSsh.nix"

    ./sops-config/pxder.nix
    ./sops-config/sg_cli.nix
    ./sops-config/ArchiSteamFarm.nix

    "${inputs.Vanilla}/sudoNoLecture.nix"
    "${inputs.Vanilla}/etcAvahiServices.nix"
    "${inputs.Vanilla}/disablePlymouthQuit.nix"

    "${inputs.Vanilla}/enableSteam.nix"
    "${inputs.Vanilla}/virtualBoxWithExt.nix"
    "${inputs.Vanilla}/adbUdevRules.nix"
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

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
