{ ... }:
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Persist the state of connected devices.
  fileSystems."/var/lib/bluetooth" = {
    device = "/persistent/var/lib/bluetooth";
    options = [ "bind" ];
  };

  # Shows the battery percent in bluez.
  hardware.bluetooth.settings = {
    "General"."Experimental" = true;
  };
}
