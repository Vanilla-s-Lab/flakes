{ config, ... }:
{
  home.file."wireguard-keys".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/root/wireguard-keys";

  home.enableDebugInfo = true;
  home.stateVersion = "22.05";
}
