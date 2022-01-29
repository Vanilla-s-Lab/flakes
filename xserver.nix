{ inputs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  imports = [
    "${inputs.Vanilla}/enableGNOME.nix"
    "${inputs.Vanilla}/minimalGNOME.nix"
  ];

  systemd.services."display-manager".preStart =
    "cp /persistent/dot/config/monitors.xml /run/gdm/.config/monitors.xml";
}
