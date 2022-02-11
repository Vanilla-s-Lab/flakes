{ config, nixosConfig, ... }:
{
  home.file.".yubico/authorized_yubikeys".text = "vanilla:";
  home.file.".yubico/challenge-16155718".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates."challenge-16155718".path;
}
