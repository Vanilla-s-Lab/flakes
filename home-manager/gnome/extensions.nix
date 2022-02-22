{ pkgs, config, lib, ... }:
let forceG41 = ext: (ext.overrideAttrs (old: {
  patchPhase = ''sed -i 's/"40"/"40", "41"/g' metadata.json'';
})); in
let gnome-x11-gesture-daemon = pkgs.callPackage
  ../packages/gnome-x11-gesture-daemon.nix
  { }; in
{
  home.packages = [
    pkgs.gnomeExtensions.arcmenu
    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.bring-out-submenu-of-power-offlogout-button
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.gesture-improvements
    pkgs.gnomeExtensions.gsconnect
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
    pkgs.gnomeExtensions.x11-gestures
  ];

  home.file.".config/gsconnect".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/gsconnect";

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      # Bundled extensions (provided by Extensions app).
      "apps-menu@gnome-shell-extensions.gcampax.github.com"
      "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      "places-menu@gnome-shell-extensions.gcampax.github.com"
      "drive-menu@gnome-shell-extensions.gcampax.github.com"
      "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "windowsNavigator@gnome-shell-extensions.gcampax.github.com"

      # User instelled extensions.
      "arcmenu@arcmenu.com"
      "bluetooth-quick-connect@bjarosze.gmail.com"
      "blur-my-shell@aunetx"
      "BringOutSubmenuOfPowerOffLogoutButton@pratap.fastmail.fm"
      "dash-to-dock@micxgx.gmail.com"
      "espresso@coadmunkee.github.com"
      "gestureImprovements@gestures"
      "gsconnect@andyholmes.github.io"
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
      "windowIsReady_Remover@nunofarruca@gmail.com"
      "x11gestures@joseexposito.github.io"
    ];

    # Button Appearance - Menu Button Appearance - Appearance - Icon and Text
    "org/gnome/shell/extensions/arcmenu".menu-button-appearance = "Icon_Text";
    # Button Appearance - Menu Button Appearance - Text - "    Vanilla"
    "org/gnome/shell/extensions/arcmenu".custom-menu-button-text = "    Vanilla";
    # Button Appearance - Icon Appearance - Icon - Browse Icons - Custom Icon
    "org/gnome/shell/extensions/arcmenu".menu-button-icon = "Custom_Icon";
    "org/gnome/shell/extensions/arcmenu".custom-menu-button-icon =
      builtins.toString (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com" +
          "/NixOS/nixos-artwork/master/logo/white.svg";
        hash = "sha256-Ed2l6i2wi/YTcWCq23bspH/t3RYp6AodykpXF1Zgccw=";
      });

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
    # Espresso - Enable notifications - OFF
    "org/gnome/shell/extensions/espresso".show-notifications = false;

    # GSConnect - Mobile Devices - Movile Settings - Redmi K30 - Pair
    "org/gnome/shell/extensions/gsconnect/device/15da62e6592a7f47".certificate-pem = "";
    "org/gnome/shell/extensions/gsconnect/device/15da62e6592a7f47".paired = true;

    # OpenWeather - Locations - [ Location + Provider ]
    "org/gnome/shell/extensions/openweather".city =
      "35.2791075,113.8452766>卫滨区, 新乡市, 河南省, 中国 >-2" + " && "
      + "28.6851715,115.9572763>青山湖区, 南昌市, 江西省, 中国 >-2";
    # OpenWeather - Units - Temperature Unit - °C
    "org/gnome/shell/extensions/openweather".unit = "celsius";
    # OpenWeather - Layout - Position in Panel - Left
    "org/gnome/shell/extensions/openweather".position-in-panel = "left";
    # OpenWeather - Layout - Conditions in Panel - ON
    "org/gnome/shell/extensions/openweather".show-comment-in-panel = true;
    # OpenWeather - Fix refresh weather issues after reboot.
    "org/gnome/shell/extensions/openweather".actual-city = 0;

    # Screenshot Tool - Auto-Copy to Clipboard - Image Data
    "org/gnome/shell/extensions/screenshot".clipboard-action = "set-image-data";

    # Sensory Perception - Display decimal value
    "org/gnome/shell/extensions/sensory-perception".display-decimal-value = true;
    # Sensory Perception - Sensor in panel - Package id 0
    "org/gnome/shell/extensions/sensory-perception".main-sensor = "Package id 0";

    # Simple net speed - [ click once to show B/s ]
    "org/gnome/shell/extensions/simplenetspeed".mode = 1;

    # Sound IO Device Chooser - General Settings - Display audio profiles for selection - OFF
    "org/gnome/shell/extensions/sound-output-device-chooser".show-profiles = false;
    # Sound IO Device Chooser - Icons - Icon Theme - None
    "org/gnome/shell/extensions/sound-output-device-chooser".icon-theme = "none";

    # Status Area Horizontal Spacing - Right key * 3 times.
    "org/gnome/shell/extensions/status-area-horizontal-spacing".hpadding = 5;

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

  home.activation."GSConnect_certificate-pem" =
    lib.hm.dag.entryAfter [ "dconfSettings" ] ''
      cert=`cat /run/secrets/gsconnect/certificate-pem` && DCONF_DBUS_RUN_SESSION="${pkgs.dbus}/bin/dbus-run-session"
      $DCONF_DBUS_RUN_SESSION dconf write /org/gnome/shell/extensions/gsconnect/device/15da62e6592a7f47/certificate-pem \""$cert"\"
    '';

  # gesture_improvements_gesture_daemon.service
  systemd.user.services."gesture_improvements_gesture_daemon" = {
    Unit = {
      Requires = "dbus.service";
      Description = "gesture improvements Gesture Daemon";
      StartLimitInterval = 0;
    };

    Service = {
      Type = "simple";
      ExecStart = "${gnome-x11-gesture-daemon}/bin/gesture_improvements_gesture_daemon";
      Restart = "always";
      RestartSec = "1s";
    };
  };
}
