{ config, ... }:
{
  # https://github.com/fish-shell/fish-shell/issues/8627
  fileSystems."/home/vanilla/.local/share/fish" = {
    device = "/persistent/dot/local/share/fish";
    options = [ "bind" ];
  };

  users.users."vanilla".uid = 1000;
  users.groups."users".gid = 100;

  # Credit: @NickCao.
  # Permissions of bind mount follows the parents.
  fileSystems."/home/vanilla/.local/share" = {
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" ]
      ++ [ "uid=1000" "gid=100" ];
  };

  # ~/.local are also should be accessable.
  fileSystems."/home/vanilla/.local" = {
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" ]
      ++ [ "uid=1000" "gid=100" ];
  };

  # Used for persist fish_history for user root.
  fileSystems."/root/.local/share/fish" = {
    device = "/persistent/root/dot/local/share/fish";
    options = [ "bind" ];
  };
}
