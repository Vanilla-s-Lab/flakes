{ ... }:
{
  networking.nameservers = [ "127.0.0.1" "::1" ];
  networking.resolvconf.enable = false;

  networking.networkmanager.dns = "none";

  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.settings = {
    ipv6_servers = true;
    require_dnssec = true;

    listen_addresses = [ "0.0.0.0:53" ];
    server_names = [ "alidns-doh" "dnspod-doh" "adguard-dns" ];
  };
}
