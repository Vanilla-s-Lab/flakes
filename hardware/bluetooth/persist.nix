{ ... }:
{
  fileSystems."/var/lib/bluetooth" = {
    device = "/persistent/var/lib/bluetooth";
    options = [ "bind" ];
  };
}
