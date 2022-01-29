{ pkgs, inputs, config, ... }:
{
  home.packages = [ pkgs.qv2ray ];
  imports = [ "${inputs.Vanilla}/prepareVCore.nix" ];

  home.file.".config/qv2ray".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/qv2ray";
}
