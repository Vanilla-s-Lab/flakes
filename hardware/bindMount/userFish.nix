{ ... }:
{
  fileSystems."/home/vanilla/.local/share/fish" = {
    device = "/persistent/dot/local/share/fish";
    options = [ "bind" ];
  };
}
