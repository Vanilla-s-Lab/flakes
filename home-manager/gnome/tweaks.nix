{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnome.gnome-tweaks

    pkgs.layan-gtk-theme
    pkgs.breeze-gtk
    pkgs.tela-icon-theme

    # https://github.com/NixOS/nixpkgs/pull/184000
    (pkgs.flat-remix-gnome.overrideAttrs (old: rec {
      pname = "flat-remix-gnome";
      version = "20220622";

      src = pkgs.fetchFromGitHub {
        repo = "${pname}";
        owner = "daniruiz";
        rev = "${version}";
        hash = "sha256-fm1YOKI6TLkCnkkPZkp8I0xWkNrZt4sVktYZyD5foKU=";
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
