{ inputs, system, ... }: with inputs;
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/170573
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/bluetooth" ];
  };

  # Shows the battery percent in bluez.
  hardware.bluetooth.settings."General" = {
    "Experimental" = true;
  };

  # https://github.com/atar-axis/xpadneo/issues/259
  hardware.xpadneo.enable = true;
}
