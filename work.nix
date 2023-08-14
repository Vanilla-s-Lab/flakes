{ lib, ... }:
{
  # services.elasticsearch.enable = true;
  services.elasticsearch.extraConf = ''
    # https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-minimal-setup.html
    xpack.security.enabled: true

    # https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html
    xpack.security.transport.ssl.enabled: true

    # https://alexmarquardt.com/2018/11/05/security-tls-ssl-pki-authentication-in-elasticsearch/
    xpack.security.transport.ssl.keystore.path: certs/elastic-certificates.p12

    # https://discuss.elastic.co/t/how-to-disable-geoip-usage-in-7-14-0/281076
    ingest.geoip.downloader.enabled: false
  '';

  # https://github.com/NixOS/nixpkgs/pull/125404/commits/3a1e1f062432fbc867502187972b37f7a6f9fe63
  systemd.services.elasticsearch = {
    postStart = lib.mkForce "";
  };

  # services.kibana.enable = true;
  services.kibana.elasticsearch.username = "kibana_system";
  services.kibana.elasticsearch.password = "RnTfFEhR32KaIGDeo1mD";

  # https://www.elastic.co/guide/en/kibana/current/xpack-security-secure-saved-objects.html
  services.kibana.extraConf = {
    "xpack.encryptedSavedObjects" = {
      encryptionKey = "min-32-byte-long-NEW-encryption-key";
    };
  };

  # services.grafana.enable = true;
  services.grafana.settings = { };
}
