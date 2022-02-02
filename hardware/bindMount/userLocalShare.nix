{ ... }:
{
  fileSystems."/home/vanilla/.local/share" = {
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" ]
      ++ [ "uid=1000" "gid=100" ];
  };
}
