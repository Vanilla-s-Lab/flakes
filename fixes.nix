{ ... }:
{
  # Avahi requires /etc/avahi/services file.
  environment.etc."avahi/services".text = "";

  # Disable plymouth-quit to remove journal log.
  systemd.services."plymouth-quit".enable = false;
}
