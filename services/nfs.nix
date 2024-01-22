{ ... }:
{
  fileSystems."/export/maimai" = {
    device = "/Games/maimai";
    options = [ "bind" ];
  };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export/maimai *(ro,anonuid=1000)
  '';

  networking.firewall.allowedTCPPorts = [ 2049 ];
}
