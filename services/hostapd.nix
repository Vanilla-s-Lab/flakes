{ ... }:
{
  services.hostapd.enable = true;
  services.hostapd.interface = "wlp0s20f3";

  # https://en.wikipedia.org/wiki/ISO_3166-1
  services.hostapd.countryCode = "CN";

  services.hostapd.ssid = "Never Gonna Give You Up";
  services.hostapd.wpa = false;
}
