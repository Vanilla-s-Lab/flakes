{ ... }:
{
  # networking.networkmanager.enable = true;
  networking.interfaces."eth0".useDHCP = true;

  services.openssh.enable = true;
  networking.hostName = "NixOS-Raspi";

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
}
