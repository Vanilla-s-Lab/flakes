{ ... }:
{
  imports = [
    ./bluetooth.nix

    ./nvidia/default.nix
    ./microcode/default.nix

    ./fileSystems.nix
    ./bindMount.nix
    ./pulseaudio.nix
  ];
}
