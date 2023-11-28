{ lib, pkgs, ... }:
{
  programs.steam.enable = true;
  programs.steam.package = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      nur.repos.vanilla.Win10_LTSC_2021_fonts
    ];
  };

  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
  };

  # https://github.com/joaorb64/joycond-cemuhook
  services.joycond.enable = true;

  # https://github.com/VergeDX/joycond-cemuhook
  boot.initrd.kernelModules = [ "hid_nintendo" ];

  # https://github.com/rofl0r/proxychains-ng
  environment.systemPackages = [ pkgs.proxychains-ng ];

  environment.etc."proxychains.conf".text = ''
    [ProxyList]
    socks5 127.0.0.1 1089
  '';
}
