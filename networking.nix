{ ... }:
{
  # Define your hostname.
  networking.hostName = "NixOS-RoT";
  networking.domain = "vanilla.local";

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Use NetworkManager, persist WiFi connections.
  networking.networkmanager.enable = true;
  environment.etc."NetworkManager/system-connections".source =
    "/persistent/etc/NetworkManager/system-connections";
}
