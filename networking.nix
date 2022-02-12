{ pkgsUnstable, ... }:
{
  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 1089 8889 ];
  networking.firewall.allowedUDPPorts = [ 1089 8889 ];
}
