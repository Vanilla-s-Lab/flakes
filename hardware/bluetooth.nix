{ ... }:
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # https://www.freedesktop.org/software/systemd/man/tmpfiles.d.html
  systemd.tmpfiles.rules = [
    "L /var/lib/bluetooth - - - - /persistent/var/lib/bluetooth"
  ];

  # Shows the battery percent in bluez.
  hardware.bluetooth.settings."General" = {
    "Experimental" = true;
  };

  # https://github.com/atar-axis/xpadneo/issues/259
  hardware.xpadneo.enable = true;
}
