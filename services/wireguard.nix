{ ... }:
{
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820;

      privateKeyFile = "/root/wireguard-keys/private";

      peers = [
        {
          publicKey = "TZtiztF9yX/E4Eq6qMm/sX8dnRtDMWxAcssz7w7hGGs=";
          allowedIPs = [ "10.100.0.0/24" ];

          # https://relay.nekoneko.cloud/
          # endpoint = "139.162.105.188:51820";
          endpoint = "221.131.165.89:45000";

          persistentKeepalive = 25;
        }
      ];
    };
  };
}
