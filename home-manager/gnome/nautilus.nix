{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.nautilus
    pkgs.gnome.sushi
  ];

  dconf.settings = {
    # Nautilus - Scroll Down Twice.
    "org/gnome/nautilus/icon-view".default-zoom-level = "small";
    # Nautilus - Let sidebar contains '[ip]:...' of ftp.
    "org/gnome/nautilus/window-state".sidebar-width = 211;
  };

  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/vanilla/Projects Projects
  '';
}
