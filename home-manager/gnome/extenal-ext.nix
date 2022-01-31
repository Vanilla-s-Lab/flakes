{ pkgs, ... }:
let forceG41 = ext: (ext.overrideAttrs (old: {
  patchPhase = ''sed -i 's/"40"/"40", "41"/g' metadata.json'';
})); in
{
  home.packages = [
    pkgs.gnomeExtensions.arcmenu
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.bring-out-submenu-of-power-offlogout-button
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.kimpanel
    pkgs.gnomeExtensions.lock-keys
    (forceG41 pkgs.gnomeExtensions.openweather)
    pkgs.gnomeExtensions.runcat
    pkgs.gnomeExtensions.screenshot-tool
    pkgs.gnome.gnome-screenshot
    pkgs.gnomeExtensions.sensory-perception
    pkgs.lm_sensors
    pkgs.gnomeExtensions.simple-net-speed
    pkgs.gnomeExtensions.sound-output-device-chooser
    pkgs.gnomeExtensions.status-area-horizontal-spacing
    pkgs.gnomeExtensions.unite
    pkgs.gnomeExtensions.vitals

    pkgs.gnomeExtensions.window-is-ready-remover
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
      "lockkeys@vaina.lt"
      "openweather-extension@jenslody.de"
      "runcat@kolesnikov.se"
      "gnome-shell-screenshot@ttll.de"
      "sensory-perception@HarlemSquirrel.github.io"
      "simplenetspeed@biji.extension"
      "sound-output-device-chooser@kgshank.net"
      "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
      "unite@hardpixel.eu"
      "Vitals@CoreCoding.com"
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

    # OpenWeather - Locations - [ Location + Provider ]
    "org/gnome/shell/extensions/openweather".city =
      "35.2791075,113.8452766>卫滨区, 新乡市, 河南省, 中国 >-2" + " && "
      + "28.6851715,115.9572763>青山湖区, 南昌市, 江西省, 中国 >-2";
    # OpenWeather - Units - Temperature Unit - °C
    "org/gnome/shell/extensions/openweather".unit = "celsius";

    # Screenshot Tool - Auto-Copy to Clipboard - Image Data
    "org/gnome/shell/extensions/screenshot".clipboard-action = "set-image-data";

    # Sensory Perception - Display decimal value
    "org/gnome/shell/extensions/sensory-perception".display-decimal-value = true;

    # Simple net speed - [ click once to show B/s ]
    "org/gnome/shell/extensions/simplenetspeed".mode = 1;

    # Sound IO Device Chooser - General Settings - Display audio profiles for selection - OFF
    "org/gnome/shell/extensions/sound-output-device-chooser".show-profiles = false;
    # Sound IO Device Chooser - Icons - Icon Theme - None
    "org/gnome/shell/extensions/sound-output-device-chooser".icon-theme = "none";

    # Unite - General - Expand top bar left box - OFF
    "org/gnome/shell/extensions/unite".extend-left-box = false;
    # Unite - General - Auto focus new windows - OFF
    "org/gnome/shell/extensions/unite".autofocus-windows = false;
    # Unite - General - Hide window titlebars - Never
    "org/gnome/shell/extensions/unite".hide-window-titlebars = "never";
    # Unite - General - Show window title in app menu - Never
    "org/gnome/shell/extensions/unite".show-window-title = "never";
    # Unite - General - Show window buttons in top bar - Never
    "org/gnome/shell/extensions/unite".show-window-buttons = "never";
    # Unite - General - Notification messages position - Center
    "org/gnome/shell/extensions/unite".notifications-position = "center";
    # Unite - Appearance - Hide app menu application icon - OFF
    "org/gnome/shell/extensions/unite".hide-app-menu-icon = false;
    # Unite - Appearance - Reduce top bar items spacing - OFF
    "org/gnome/shell/extensions/unite".reduce-panel-spacing = false;

    # Vitals - General - Use higher precision - ON
    "org/gnome/shell/extensions/vitals".use-higher-precision = true;
    # Vitals - Sensors - Monitor network - Network Preferences - Include public IP address - ON
    "org/gnome/shell/extensions/vitals".include-public-ip = true;
    # Vitals - Sensors - Monitor battery - ON
    "org/gnome/shell/extensions/vitals".show-battery = true;
  };
}
