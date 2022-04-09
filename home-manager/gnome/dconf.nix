{ config, ... }:
{
  dconf.settings = {
    "org/gnome/shell".welcome-dialog-last-shown-version = "42";

    # https://wiki.archlinux.org/title/Activating_numlock_on_bootup#GNOME
    "org/gnome/desktop/peripherals/keyboard".numlock-state = true;
  };

  home.file.".ssh/id_ed25519".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/ssh/id_ed25519";
  home.file.".ssh/id_ed25519.pub".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/ssh/id_ed25519.pub";
  home.file.".ssh/id_ed25519_sk".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/ssh/id_ed25519_sk";
  home.file.".ssh/id_ed25519_sk.pub".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/ssh/id_ed25519_sk.pub";
}
