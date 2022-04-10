{ ... }:
{
  services.dhcpd4.enable = true;
  services.dhcpd4.interfaces = [ "wlan0" ];

  # https://trevphil.com/posts/captive-portal
  services.dhcpd4.extraConfig = ''
    subnet 10.0.10.0 netmask 255.255.255.0 {
            range 10.0.10.2 10.0.10.254;
            option domain-name-servers 10.0.10.1;
            option routers 10.0.10.1;
            interface wlan0;
    }
  '';

  networking.interfaces."wlan0".ipv4.addresses = [{
    address = "10.0.10.1";
    prefixLength = 24;
  }];

  networking.firewall.extraCommands = ''
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  '';
}
