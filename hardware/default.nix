{ ... }:
{
  imports = [
    ./bluetooth.nix
    ./nvidia.nix
    ./microcode.nix
    ./fileSystems.nix
    ./bindMount.nix
    ./pulseaudio.nix
  ];
}
