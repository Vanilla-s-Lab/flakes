{ ... }:
{
  dconf.settings = {
    # Settings - Search - OFF
    "org/gnome/desktop/search-providers".disable-external = true;

    # Settings - Privacy - Camera - OFF
    "org/gnome/desktop/privacy".disable-camera = true;
    # Settings - Privacy - Microphone - OFF
    "org/gnome/desktop/privacy".disable-microphone = true;

    # Settings - Displays - Night Light - ON
    "settings-daemon/plugins/color".night-light-enabled = true;

    # Settings - Mouse & Touchpad - Tap to click - ON
    "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;

    # Settings - Removable Media - Never prompt or start programs on media insertion
    "org/gnome/desktop/media-handling".autorun-never = true;

    # Settings - Accessibility - Always Show Accessibility Menu - ON
    "org/gnome/desktop/a11y".always-show-universal-access-status = true;
  };
}
