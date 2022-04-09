{ ... }:
{
  programs.steam.enable = true;
  # programs.steam.remotePlay.openFirewall = true;
  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
  };
}
