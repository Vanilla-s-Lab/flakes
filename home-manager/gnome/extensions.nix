{ pkgs, config, lib, generated, system, ... }:
{
  home.packages = [
    (pkgs.gnomeExtensions.arcmenu.overrideAttrs (old: rec {
      version = "52";

      src = pkgs.fetchgit {
        url = "https://gitlab.com/arcmenu/ArcMenu.git";
        rev = "v${version}";
        hash = "sha256-nZRdNkS4JfSwtqQsROKa1+eqcgwMQwVsqgeWVPpZIi0=";
      };

      # https://github.com/NixOS/nixpkgs/pull/270142/files
      patches = lib.singleton (pkgs.substituteAll {
        src = ./patches/fix_gmenu.patch;
        gmenu_path = "${pkgs.gnome-menus}/lib/girepository-1.0";
      });
    }))

    pkgs.gnomeExtensions.bluetooth-quick-connect
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.bring-out-submenu-of-power-offlogout-button
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.espresso
    pkgs.gnomeExtensions.kimpanel
    pkgs.gnomeExtensions.lock-keys

    # https://gitlab.com/skrewball/openweather/-/issues/81
    (pkgs.gnomeExtensions.openweather.overrideAttrs (old: {
      src = pkgs.fetchgit {
        url = "https://github.com/toppk/gnome-shell-extension-openweather.git";
        rev = "9117377" + "4684eb554a8c6249f9c1e012dc58fd668";
        hash = "sha256-F9SiuZZye89T8TBdSCqetUkiIygRuprviU04xQZz1ns=";
      };

      buildPhase = ''
        make _build
      '';

      installPhase = ''
        mkdir -p $out/share/gnome-shell/extensions/openweather-extension@jenslody.de
        cp -r _build/* $_
      '';
    }))

    pkgs.gnomeExtensions.runcat

    (pkgs.gnomeExtensions.screenshot-tool.overrideAttrs (old: {
      src = pkgs.fetchurl {
        url = "https://choum.net/JA/gnome-shell-screenshot@ttll.de.zip";
        hash = "sha256-lGkh9FtQ09YQRFlRmWy7o0b34mKidKpfhllj8Kz0mE4=";
      };

      buildInputs = [ pkgs.unzip ];
    }))

    pkgs.gnome.gnome-screenshot
    pkgs.gnomeExtensions.pinguxnetlabel

    (pkgs.gnomeExtensions.status-area-horizontal-spacing.overrideAttrs (old: rec {
      version = "3.0";

      src = pkgs.fetchgit {
        url = "https://gitlab.com/p91paul/status-area-horizontal-spacing-gnome-shell-extension";
        rev = "v${version}";
        hash = "sha256-+z+cYr//8SLQfaQHufCbJlkTWaenoyTVMezNU8ZgIVo=";
      };

      buildPhase = "make";

      installPhase = ''
        mkdir -p $out/share/gnome-shell/extensions
        cp -r status-area-horizontal-spacing@mathematical.coffee.gmail.com $_
      '';
    }))

    (pkgs.gnomeExtensions.unite.overrideAttrs (old: {
      version = "77";

      src = pkgs.fetchurl {
        url = "https://github.com/hardpixel/unite-shell/releases/download/v77/unite-shell-v77.zip";
        hash = "sha256-Am80rBgKFuZRkH95K7nFPteyEF0+BNes93JiaIBCmdM=";
      };

      buildInputs = [ pkgs.unzip ];
    }))

    pkgs.gnomeExtensions.vitals
    pkgs.gnomeExtensions.window-is-ready-remover

    (pkgs.gnomeExtensions.gtile.overrideAttrs (old: rec {
      version = "54";

      src = pkgs.fetchurl {
        url = "https://github.com/gTile/gTile/releases/download/V${version}/gtile.dist.tgz";
        hash = "sha256-xKvT2NS81tSjlNM0QquthijNOmWYkPFKqYrsod8c2rE=";
      };

      unpackPhase = ''
        mkdir gTile@vibou && cd $_
        tar -xf $src .
      '';
    }))

    pkgs.gnomeExtensions.clipboard-indicator
  ];

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
      "kimpanel@kde.org"
      "lockkeys@vaina.lt"
      "openweather-extension@jenslody.de"
      "runcat@kolesnikov.se"
      "gnome-shell-screenshot@ttll.de"
      "pinguXnetLabel@pinguX.aTa"
      "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
      "unite@hardpixel.eu"
      "Vitals@CoreCoding.com"
      "windowIsReady_Remover@nunofarruca@gmail.com"

      "gTile@vibou"

      "clipboard-indicator@tudmotu.com"
    ];

    # General - Panel Display Options - Show Activities Button - ON
    "org/gnome/shell/extensions/arcmenu".show-activities-button = true;
    # General - General Settings - ArcMenu Hotkey - OFF
    "org/gnome/shell/extensions/arcmenu".enable-menu-hotkey = false;
    # Button Appearance - Menu Button Appearance - Appearance - Icon and Text
    "org/gnome/shell/extensions/arcmenu".menu-button-appearance = "Icon_Text";
    # Button Appearance - Menu Button Appearance - Text - "    Vanilla"
    "org/gnome/shell/extensions/arcmenu".custom-menu-button-text = "    Vanilla";
    # Button Appearance - Icon Appearance - Icon - Browse Icons - Distro Icons - Arch
    "org/gnome/shell/extensions/arcmenu".menu-button-icon = "Distro_Icon";
    "org/gnome/shell/extensions/arcmenu".distro-icon = 6;

    # Bluetooth Quick Connect - Show battery value (restart required) - ON
    "org/gnome/shell/extensions/bluetooth-quick-connect".show-battery-value-on = true;
    # Bluetooth Quick Connect - Show battery icon (restart required) - OFF
    "org/gnome/shell/extensions/bluetooth-quick-connect".show-battery-icon-on = false;

    # Blur my shell - Panel - Panel blur - OFF
    "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
    # Blur my shell - Dash - Dash to Dock blur - OFF
    "org/gnome/shell/extensions/blur-my-shell".dash-to-dock-blur = false;

    # Dash to Dock - Position and size - Show on all monitors.
    "org/gnome/shell/extensions/dash-to-dock".multi-monitor = true;
    # Dash to Dock - Launchers - Isolate [ workspaces | monitors ].
    "org/gnome/shell/extensions/dash-to-dock".isolate-workspaces = true;
    "org/gnome/shell/extensions/dash-to-dock".isolate-monitors = true;
    # Dash to Dock - Behavior - Click action - Minimize
    "org/gnome/shell/extensions/dash-to-dock".click-action = "minimize";
    # Dash to Dock - Behavior - Scroll action - Cycle through windows
    "org/gnome/shell/extensions/dash-to-dock".scroll-action = "cycle-windows";
    # Dash to Dock - Appearance - Customize windows counter indicators - Dots
    "org/gnome/shell/extensions/dash-to-dock".running-indicator-style = "DOTS";
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
    # Espresso - Enable when this device is charging - ON
    "org/gnome/shell/extensions/espresso".enable-charging = true;

    # OpenWeather - Locations - [ Location + Provider ]
    "org/gnome/shell/extensions/openweather".city =
      "30.6438936,104.0405084>武侯区, 成都市, 四川省, 中国 >0";
    # OpenWeather - Units - Temperature Unit - °C
    "org/gnome/shell/extensions/openweather".unit = "celsius";
    # OpenWeather - Layout - Position in Panel - Left, 5
    "org/gnome/shell/extensions/openweather".position-in-panel = "left";
    "org/gnome/shell/extensions/openweather".position-index = 4;
    # OpenWeather - Layout - Conditions in Panel - ON
    "org/gnome/shell/extensions/openweather".show-comment-in-panel = true;
    # OpenWeather - Fix refresh weather issues after reboot.
    "org/gnome/shell/extensions/openweather".actual-city = 1;

    # RunCat Settings - Displaying Items = Character and percentage.
    "org/gnome/shell/extensions/runcat".displaying-items = "character-and-percentage";

    # Screenshot Tool - Auto-Copy to Clipboard - Image Data
    "org/gnome/shell/extensions/screenshot".clipboard-action = "set-image-data";

    # Status Area Horizontal Spacing - Horizontal Padding.
    "org/gnome/shell/extensions/status-area-horizontal-spacing".hpadding = 5;

    # Unite - General - Expand top bar left box - OFF
    "org/gnome/shell/extensions/unite".extend-left-box = false;
    # Unite - General - Auto focus new windows - OFF
    "org/gnome/shell/extensions/unite".autofocus-windows = false;
    # Unite - General - Hide activities button - Never
    "org/gnome/shell/extensions/unite".hide-activities-button = "never";
    # Unite - General - Hide window titlebars - Never
    "org/gnome/shell/extensions/unite".hide-window-titlebars = "never";
    # Unite - General - Show window title in app menu - Never
    "org/gnome/shell/extensions/unite".show-window-title = "never";
    # Unite - General - Show window buttons in top bar - Never
    "org/gnome/shell/extensions/unite".show-window-buttons = "never";
    # Unite - General - Notification messages position - Center
    "org/gnome/shell/extensions/unite".notifications-position = "center";
    # Unite - Appearance - Use text in activities button - OFF
    "org/gnome/shell/extensions/unite".use-activities-text = false;
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
    # Vitals Icon - Network - Device rx - OFF, [ Memory - Usage | System - Load 1m ] - ON
    "org/gnome/shell/extensions/vitals".hot-sensors = [ "_memory_usage_" "_system_load_1m_" ];
  };
}
