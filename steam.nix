{ lib, pkgs, ... }:
{
  programs.steam.enable = true;
  # programs.steam.remotePlay.openFirewall = true;

  nixpkgs.overlays = lib.singleton (self: super: {
    steam = super.steam.override {
      extraPkgs = pkgs: with pkgs; [
        nur.repos.vanilla.Win10_LTSC_2021_fonts

        pkgs.openssl_3_0
        pkgs.libadwaita
        pkgs.gtk4
      ];
    };
  });

  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
  };

  # https://github.com/joaorb64/joycond-cemuhook
  services.joycond.enable = true;

  # https://github.com/VergeDX/joycond-cemuhook
  boot.initrd.kernelModules = [ "hid_nintendo" ];
}
