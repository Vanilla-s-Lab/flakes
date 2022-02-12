{ pkgsUnstable, ... }:
{
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 1089 8889 ];
  networking.firewall.allowedUDPPorts = [ 1089 8889 ];
}
