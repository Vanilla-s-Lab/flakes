{ ... }:
{
  imports = [
    ./bluetooth.nix

    ./nvidia/default.nix

    ./microcode.nix
    ./fileSystems.nix
    ./bindMount.nix
    ./pulseaudio.nix
  ];
}
