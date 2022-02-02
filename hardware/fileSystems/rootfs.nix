{ ... }:
{
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [ "defaults" "size=3G" "mode=755" ];
  };
}
