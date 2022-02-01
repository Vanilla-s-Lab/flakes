{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.nautilus
    pkgs.gnome.sushi
  ];

  dconf.settings = {
    # Nautilus - Scroll Down Twice.
    "org/gnome/nautilus".default-zoom-level = "small";
  };

  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/vanilla/Projects Projects
  '';
}
