{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweaks

    pkgs.layan-gtk-theme
    pkgs.breeze-gtk
    pkgs.tela-icon-theme
    pkgs.flat-remix-gnome
  ];

  dconf.settings = {
    # Extensions Has Moved - Continue
    "org/gnome/tweaks".show-extensions-notice = false;

    # Genernal - Over-Amplification - ON
    "org/gnome/desktop/sound".allow-volume-above-100-percent = true;

    # Appearance - Themes - Applications | Cursor | Icons | Shell
    "org/gnome/desktop/interface".gtk-theme = "Layan-light-solid";
    "org/gnome/desktop/interface".cursor-theme = "breeze_cursors";
    "org/gnome/desktop/interface".icon-theme = "Tela-pink";
    "org/gnome/shell/extensions/user-theme".name = "Flat-Remix-Blue-Light";

    # Appearance - [ Background | Lock Screen ] - Image
    "org/gnome/desktop/background".picture-uri = "file:///home/vanilla/Pictures/bg.jpg";
    "org/gnome/desktop/screensaver"picture-uri = "file:///home/vanilla/Pictures/bg.jpg";
  };
}
