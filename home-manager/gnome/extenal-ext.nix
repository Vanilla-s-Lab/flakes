{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnomeExtensions.arcmenu

    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.openweather
    pkgs.gnomeExtensions.simple-net-speed
    pkgs.gnomeExtensions.proxy-switcher
    pkgs.gnomeExtensions.screenshot-tool
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.status-area-horizontal-spacing
    pkgs.gnomeExtensions.window-is-ready-remover
    pkgs.gnomeExtensions.lock-keys
    pkgs.gnomeExtensions.disconnect-wifi
    pkgs.gnomeExtensions.sensory-perception
    pkgs.gnomeExtensions.vitals
    pkgs.gnomeExtensions.bring-out-submenu-of-power-offlogout-button
    pkgs.gnomeExtensions.kimpanel
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      "arcmenu@arcmenu.com"
    ];

    # Button Appearance - Menu Button Appearance - Appearance - Icon and Text
    "org/gnome/shell/extensions/arcmenu".menu-button-appearance = "Icon_Text";
    # Button Appearance - Menu Button Appearance - Text - "    Vanilla"
    "org/gnome/shell/extensions/arcmenu".custom-menu-button-text = "    Vanilla";
    # Button Appearance - Icon Appearance - Icon - Browse Icons - Custom Icon
    "org/gnome/shell/extensions/arcmenu".custom-menu-button-icon =
      "/home/vanilla/Projects/nixos-artwork/logo/white.svg";
  };
}
