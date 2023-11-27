{ pkgs, ... }:
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
{
  home.packages = [
    pkgs.gnome.gnome-tweaks

    (pkgs.layan-gtk-theme.overrideAttrs (old: {
      version = generated."vinceliuice_Layan-gtk-theme".src.rev;
      src = generated."vinceliuice_Layan-gtk-theme".src;
    }))

    pkgs.breeze-gtk
    pkgs.tela-icon-theme

    (pkgs.flat-remix-gnome.overrideAttrs (old: {
      version = generated."daniruiz_flat-remix-gnome".src.rev;
      src = generated."daniruiz_flat-remix-gnome".src;
    }))
  ];

  dconf.settings = {
    # Extensions Has Moved - Continue
    "org/gnome/tweaks".show-extensions-notice = false;

    # Genernal - Over-Amplification - ON
    "org/gnome/desktop/sound".allow-volume-above-100-percent = true;

    # Appearance - Themes - Applications | Cursor | Icons | Shell
    "org/gnome/desktop/interface".gtk-theme = "Layan-Light-Solid";
    "org/gnome/desktop/interface".cursor-theme = "breeze_cursors";
    "org/gnome/desktop/interface".icon-theme = "Tela-pink";

    # With extension "Workspace Scroll", compact.
    "org/gnome/shell/extensions/user-theme".name =
      ("Flat-Remix-Blue-Light" + "-fullPanel");

    # Appearance - [ Background | Lock Screen ] - Image
    "org/gnome/desktop/background".picture-uri = "file:///home/vanilla/Pictures/bg.jpg";
    "org/gnome/desktop/screensaver".picture-uri = "file:///home/vanilla/Pictures/bg.jpg";

    # Fonts - Interface Text
    "org/gnome/desktop/interface".font-name = "SF Compact Display 11";

    # Top Bar - Battery Percentage
    "org/gnome/desktop/interface".show-battery-percentage = true;
    # Top Bar - Clock - [ Weekday | Seconds ]
    "org/gnome/desktop/interface".clock-show-weekday = true;
    "org/gnome/desktop/interface".clock-show-seconds = true;

    # Window Titlebars - Titlebar Actions - Middle-Click - Minimize
    "org/gnome/desktop/wm/preferences".action-middle-click-titlebar = "minimize";
    # Window Titlebars - Titlebar Buttons - [ Maximize | Minimize ] - ON
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
  };
}
