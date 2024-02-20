{ pkgs, config, lib, inputs, nixosConfig, generated, ... }:
# WeChat ID: My_Aim_Sucks
let wxid = "wxid_2tafg8vy4onr22"; in
{
  home.packages = [
    pkgs.gnome.nautilus
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

    "org/gnome/nautilus/window-state" = {
      # Nautilus - Let sidebar contains '[ip]:...' of ftp.
      sidebar-width = 211;

      # Type: (ii), Default value: (890, 550).
      initial-size = (lib.hm.gvariant.mkTuple
        [ 890 (550 + (117 - 69)) ]);
    };

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
    file:///home/vanilla/Works Works
    file:///home/vanilla/Projects Projects
    file:///home/vanilla/Documents/WeChat%20Files/${wxid}/FileStorage/File wechat_file
  '';

  # https://github.com/NixOS/nixpkgs/issues/163080
  home.file.".face".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Pictures/avatar.png";
}
