{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/PulseAudio
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # https://nixos.wiki/wiki/Bluetooth#Enabling_extra_codecs
  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
