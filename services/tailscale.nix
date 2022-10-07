{ lib, config, ... }:
{
  services.tailscale.enable = true;
  services.tailscale.interfaceName = "tailscale";

  networking.firewall.allowedUDPPorts = lib.singleton
    config.services.tailscale.port;

  networking.firewall.checkReversePath = "loose";

  # https://nixos.wiki/wiki/Impermanence
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/tailscale" ];
  };
}
