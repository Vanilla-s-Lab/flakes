{ config, ... }:
{
  # https://github.com/fish-shell/fish-shell/issues/8627
  fileSystems."/home/vanilla/.local/share/fish" = {
    device = "/persistent/dot/local/share/fish";
    options = [ "bind" ];
  };

  users.users."vanilla".uid = 1000;
  users.groups."users".gid = 100;

  fileSystems."/home/vanilla/.local/share" = {
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" ]
      ++ [ "uid=1000" "gid=100" ];
  };
}
