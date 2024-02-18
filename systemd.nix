{ ... }:
{
  services.timesyncd.enable = true;
  services.timesyncd.servers = [
    "0.cn.pool.ntp.org"
    "1.cn.pool.ntp.org"
    "2.cn.pool.ntp.org"
    "3.cn.pool.ntp.org"
  ];

  systemd.coredump.enable = true;
  systemd.coredump.extraConfig = "Storage=none";

  # nixos/modules/services/x11/display-managers/gdm.nix
  systemd.services."plymouth-quit".enable = false;

  # https://archlinux.org/news/making-dbus-broker-our-default-d-bus-daemon/
  services.dbus.implementation = "broker";
}
