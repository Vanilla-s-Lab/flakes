{ ... }:
{
  dconf.settings = {
    # Settings - Search - OFF
    "org/gnome/desktop/search-providers".disable-external = true;

    # Settings - Privacy - Location Services - ON
    "org/gnome/system/location".enabled = true;
    # Settings - Privacy - Camera - OFF
    "org/gnome/desktop/privacy".disable-camera = true;
    # Settings - Privacy - Microphone - OFF
    "org/gnome/desktop/privacy".disable-microphone = true;

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
  };
}
