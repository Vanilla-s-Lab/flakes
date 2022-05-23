{ config, ... }:
{
  dconf.settings = {
    # Network - Network Proxy - Automatic
    "system/proxy".mode = "auto";

    # Appearance - Style - Light
    "org/gnome/desktop/interface".color-scheme = "default";

    # Settings - Search - OFF
    "org/gnome/desktop/search-providers".disable-external = true;

    # Settings - Privacy - Location Services - ON
    "org/gnome/system/location".enabled = true;
    # Settings - Privacy - Camera - OFF
    "org/gnome/desktop/privacy".disable-camera = true;
    # Settings - Privacy - Microphone - OFF
    "org/gnome/desktop/privacy".disable-microphone = true;

    # Settings - Power - Power Saving Options - Automatic Suspend - On Battery Power - OFF
    "org/gnome/settings-daemon/plugins/power".sleep-inactive-battery-type = "nothing";
    # Settings - Power - Power Saving Options - Automatic Suspend - Plugged In - OFF
    "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";

    # Settings - Displays - Night Light - ON
    "org/gnome/settings-daemon/plugins/color".night-light-enabled = true;

    # Settings - Mouse & Touchpad - Tap to click - ON
    "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;

    # Settings - Removable Media - Never prompt or start programs on media insertion
    "org/gnome/desktop/media-handling".autorun-never = true;

    # Settings - Accessibility - Always Show Accessibility Menu - ON
    "org/gnome/desktop/a11y".always-show-universal-access-status = true;

    # Settings - Date & Time - Automatic Time Zone - ON
    "org/gnome/desktop/datetime".automatic-timezone = true;
    # Settings - Date & Time - Time Format - AM/PM
    "org/gnome/desktop/interface".clock-format = "12h";

    # Settings - Last panel set to Sound, until pereiet.
    "org/gnome/control-center".last-panel = "display";
  };

  home.file.".config/monitors.xml".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/monitors.xml";

  # https://wiki.archlinux.org/title/backlight
  home.activation."backlight_set_to_60000" =
    ("echo 60000 > /sys/class/backlight/intel_backlight/brightness"
      + " " + "||" + " " + "true");
}
