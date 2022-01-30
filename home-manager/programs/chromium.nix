{ inputs, config, ... }:
{
  programs.chromium.enable = true;
  imports = [ "${inputs.Vanilla}/chromiumSync.nix" ];

  home.file.".config/chromium".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/chromium";

  home.file.".cache/chromium".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/chromium";
}
