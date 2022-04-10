{ ... }:
{
  # TODO: Use NixOS options with interface name.
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
}
