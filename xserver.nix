{ ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Disable most of GNOME bundled tools.
  services.gnome = {
    core-utilities.enable = false;
    core-developer-tools.enable = false;
  };

  # https://github.com/NixOS/nixpkgs/pull/107850
  systemd.services."display-manager".preStart =
    "cp /persistent/dot/config/monitors.xml /run/gdm/.config/monitors.xml";
}
