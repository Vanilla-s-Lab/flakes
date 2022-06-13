{ pkgs, config, ... }:
# WeChat ID: My_Aim_Sucks
let wxid = "wxid_2tafg8vy4onr22"; in
{
  home.sessionVariables = {
    # https://github.com/Stunkymonkey/nixos/blob/master/nixos/modules/nautilus.nix
    NAUTILUS_EXTENSION_DIR = "${config.home.homeDirectory}"
      + "/.nix-profile/lib/nautilus/extensions-3.0";
  };

  home.packages = [
    pkgs.gnome.nautilus
    pkgs.gnome.nautilus-python

    pkgs.gnome.sushi
    pkgs.gnome.gedit

    pkgs.epiphany
    pkgs.gnome.geary
    pkgs.gnome.gnome-calendar
    pkgs.lollypop
    pkgs.gnome.totem
    pkgs.gnome.eog

    pkgs.evince
    pkgs.thunderbird
  ];

  home.file.".thunderbird".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/thunderbird";

  home.file.".cache/thunderbird".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/thunderbird";

  dconf.settings = {
    # Nautilus - Scroll Down Twice.
    "org/gnome/nautilus/icon-view".default-zoom-level = "small";
    # Nautilus - Let sidebar contains '[ip]:...' of ftp.
    "org/gnome/nautilus/window-state".sidebar-width = 211;

    # Text Editor - Preferences - Font & Colors - Color Scheme - Flat-Remix
    "org/gnome/gedit/preferences/editor".scheme = "Flat-Remix";
    # Text Editor - Preferences - Plugins - Enable All.
    "org/gnome/gedit/plugins".active-plugins = [
      "time"
      "spell"
      "sort"
      "snippets"
      "quickopen"
      "quickhighlight"
      "pythonconsole"
      "modelines"
      "filebrowser"
      "externaltools"
      "docinfo"
    ];
  };

  # Caution: Whitespace should replaced by '%20'.
  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/vanilla/Projects Projects
    file:///home/vanilla/.local/lib/wine-wechat/default/drive_c/WeChat%20Files/${wxid}/FileStorage/File wechat_file
  '';

  # https://github.com/NixOS/nixpkgs/issues/163080
  home.file.".face".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Pictures/avatar.png";
}
