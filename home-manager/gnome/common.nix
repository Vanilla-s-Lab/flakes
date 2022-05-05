{ pkgs, config, ... }:
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

  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/vanilla/Projects Projects
  '';
}
