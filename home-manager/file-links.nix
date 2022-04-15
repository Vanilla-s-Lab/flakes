{ config, ... }:
{
  home.file."Projects".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Projects";

  home.file.".config/nixpkgs".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Projects/flakes/home-manager";

  home.file."Downloads".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Downloads";

  home.file."Pictures".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Pictures";

  home.file.".steam".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/steam";

  home.file.".local/share/Steam".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/Steam";

  home.file."Videos".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Videos";

  home.file."Documents".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Documents";

  home.file.".yubico".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/yubico";

  home.file."VirtualBox VMs".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/VirtualBox VMs";

  home.file.".cache/nix".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/nix";

  home.file.".gnupg/private-keys-v1.d".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/gnupg/private-keys-v1.d";
}
