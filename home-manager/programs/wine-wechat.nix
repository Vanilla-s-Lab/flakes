{ inputs, system, config, ... }:
{
  home.packages = with inputs;
    [ nixos-cn.legacyPackages."${system}".wine-wechat ];

  home.file.".local/lib/wine-wechat".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/lib/wine-wechat";
}
