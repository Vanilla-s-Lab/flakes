{ ... }:
{
  programs.steam.enable = true;
  boot.kernel.sysctl = {
    "dev.i915.perf_stream_paranoid" = 0;
  };
}
