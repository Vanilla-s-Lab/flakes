{ ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # NixOS/nixpkgs - nixos/modules/services/x11/desktop-managers/gnome.nix
  services.gnome.core-utilities.enable = false;
  services.gnome.core-developer-tools.enable = false;
}
