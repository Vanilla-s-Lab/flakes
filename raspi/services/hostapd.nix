{ ... }:
{
  services.hostapd.enable = true;
  services.hostapd.interface = "wlan0";

  # https://en.wikipedia.org/wiki/ISO_3166-1
  services.hostapd.countryCode = "CN";

  services.hostapd.ssid = "Never Gonna Give You Up";
  services.hostapd.wpa = false;

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.wlan0.disable_ipv6" = 1;
}
