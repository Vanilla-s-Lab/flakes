{ ... }:
{
  imports = [
    ./bluetooth.nix

    ./nvidia/default.nix
    ./microcode/default.nix
    ./fileSystems/default.nix

    ./bindMount.nix

    ./pulseaudio/default.nix
  ];
}
