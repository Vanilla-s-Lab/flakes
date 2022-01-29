{ inputs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  imports = [
    "${inputs.Vanilla}/enableGNOME.nix"
    "${inputs.Vanilla}/minimalGNOME.nix"
  ];
}
