{ ... }:
{
  fileSystems."/root/.local/share/fish" = {
    device = "/persistent/root/dot/local/share/fish";
    options = [ "bind" ];
  };
}
