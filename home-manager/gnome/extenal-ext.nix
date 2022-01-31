{ pkgs, ... }:
{
  home.packages = [
    pkgs.gnomeExtensions.arcmenu
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.bring-out-submenu-of-power-offlogout-button
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.kimpanel

    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.openweather
    pkgs.gnomeExtensions.simple-net-speed
    pkgs.gnomeExtensions.proxy-switcher
    pkgs.gnomeExtensions.screenshot-tool
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.status-area-horizontal-spacing
    pkgs.gnomeExtensions.window-is-ready-remover
    pkgs.gnomeExtensions.lock-keys
    pkgs.gnomeExtensions.sensory-perception
    pkgs.gnomeExtensions.vitals
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      "arcmenu@arcmenu.com"
      "bluetooth-quick-connect@bjarosze.gmail.com"
      "blur-my-shell@aunetx"
      "BringOutSubmenuOfPowerOffLogoutButton@pratap.fastmail.fm"
      "dash-to-dock@micxgx.gmail.com"
      "espresso@coadmunkee.github.com"
      "kimpanel@kde.org"
    ];

    # Button Appearance - Menu Button Appearance - Appearance - Icon and Text
    "org/gnome/shell/extensions/arcmenu".menu-button-appearance = "Icon_Text";
    # Button Appearance - Menu Button Appearance - Text - "    Vanilla"
    "org/gnome/shell/extensions/arcmenu".custom-menu-button-text = "    Vanilla";
    # Button Appearance - Icon Appearance - Icon - Browse Icons - Custom Icon
    "org/gnome/shell/extensions/arcmenu".menu-button-icon = "Custom_Icon";
    "org/gnome/shell/extensions/arcmenu".custom-menu-button-icon =
      "/home/vanilla/Projects/nixos-artwork/logo/white.svg";

    # Bluetooth Quick Connect - Show battery value (restart required) - ON
    "org/gnome/shell/extensions/bluetooth-quick-connect".show-battery-value-on = true;
    # Bluetooth Quick Connect - Show battery icon (restart required) - OFF
    "org/gnome/shell/extensions/bluetooth-quick-connect".show-battery-icon-on = false;

    # Blur my shell - Blue - [ dash | panel | window list extension ] - OFF
    "org/gnome/shell/extensions/blur-my-shell" =
      { blur-dash = false; blur-panel = false; blur-window-list = false; };

    # Dash to Dock - Position and size - Show on all monitors.
    "org/gnome/shell/extensions/dash-to-dock".multi-monitor = true;
    # Dash to Dock - Launchers - Isolate [ workspaces | monitors ].
    "org/gnome/shell/extensions/dash-to-dock".isolate-workspaces = true;
    "org/gnome/shell/extensions/dash-to-dock".isolate-monitors = true;
    # Dash to Dock - Behavior - Click action - Minimize
    "org/gnome/shell/extensions/dash-to-dock".click-action = "minimize";
    # Dash to Dock - Behavior - Scroll action - Cycle through windows
    "org/gnome/shell/extensions/dash-to-dock".scroll-action = "cycle-windows";
    # Dash to Dock - Appearance - Customize the dash color - ON
    "org/gnome/shell/extensions/dash-to-dock".custom-background-color = true;
    # https://matkl.github.io/average-color/ + ~/Pictures/bg.jpg
    "org/gnome/shell/extensions/dash-to-dock".background-color = "rgb(151,126,128)";
    # Dash to Dock - Appearance - Customize opacity - Dynamic
    "org/gnome/shell/extensions/dash-to-dock".transparency-mode = "DYNAMIC";

    # Espresso - Restore state across reboots - ON
    "org/gnome/shell/extensions/espresso".restore-state = true;
    "org/gnome/shell/extensions/espresso".user-enabled = true;
  };
}
