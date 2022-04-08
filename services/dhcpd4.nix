{ ... }:
{
  services.dhcpd4.enable = true;
  services.dhcpd4.interfaces = [ "wlp0s20f3" ];

  # https://trevphil.com/posts/captive-portal
  services.dhcpd4.extraConfig = ''
    subnet 10.0.10.0 netmask 255.255.255.0 {
            range 10.0.10.2 10.0.10.254;
            option domain-name-servers 223.5.5.5,223.6.6.6;
            option routers 10.0.10.1;
            interface wlp0s20f3;
    }
  '';
}
