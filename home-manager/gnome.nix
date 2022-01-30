{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweaks
    pkgs.gnome.gnome-system-monitor

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

    # Appearance - Applications | Cursor | Icons | Shell
    "org/gnome/desktop/interface".gtk-theme = "Layan-light-solid";
    "org/gnome/desktop/interface".cursor-theme = "breeze_cursors";
    "org/gnome/desktop/interface".icon-theme = "Tela-pink";
    "org/gnome/shell/extensions/user-theme".name = "Flat-Remix-Blue-Light";
  };
}
