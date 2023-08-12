{ config, ... }:
{
  home.file."Projects".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Projects";

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

  home.file.".cache/nix".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/nix";

  home.file.".gnupg/private-keys-v1.d".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/gnupg/private-keys-v1.d";

  # Used in newer version of IntelliJ IDEA - Catalog.
  home.file.".m2/repository/.placeholder".text = "";

  home.file.".local/state/wireplumber".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/state/wireplumber";

  home.file."Works".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Works";

  home.file.".android".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/android/";

  home.file."Music".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Music";

  home.file."Public".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Public";
}
