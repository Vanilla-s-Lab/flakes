{ pkgs, ... }:
{
  # https://redis.io/docs/manual/admin/
  boot.kernel.sysctl = { "vm.overcommit_memory" = 1; };
  boot.kernelParams = [ "transparent_hugepage=never" ];

  # https://wiki.archlinux.org/title/NTFS#udisks_support
  services.udisks2.enable = true;
  services.udisks2.settings."mount_options.conf" = {
    defaults = {
      ntfs_defaults = "uid=$UID,gid=$GID,noatime,prealloc";
    };
  };

  # https://nixos.wiki/wiki/Debug_Symbols
  environment.enableDebugInfo = true;
  environment.systemPackages = [ pkgs.glibc ];
}
