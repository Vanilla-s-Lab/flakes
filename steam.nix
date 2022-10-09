{ lib, pkgs, ... }:
{
  programs.steam.enable = true;
  # programs.steam.remotePlay.openFirewall = true;

  nixpkgs.overlays = lib.singleton (self: super: {
    steam = super.steam.override {
      extraPkgs = pkgs: with pkgs; [
        nur.repos.vanilla.Win10_LTSC_2021_fonts
      ];
    };
  });

  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
  };
}
