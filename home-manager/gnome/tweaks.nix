{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweaks

    pkgs.layan-gtk-theme
    pkgs.breeze-gtk
    pkgs.tela-icon-theme

    # https://github.com/NixOS/nixpkgs/pull/169670
    (pkgs.flat-remix-gnome.overrideAttrs (old: {
      version = "20220422";
      src = pkgs.fetchFromGitHub {
        owner = "daniruiz";
        repo = "${old.pname}";
        rev = "20220422";
        hash = "sha256-W/BNn10SggtBacelNljPh42jVMBfykJFRWBCaj/ar7U=";
      };
    }))
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
