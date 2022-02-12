{ ... }:
{
  fileSystems = {
    "/" = { fsType = "tmpfs"; options = [ "defaults" "size=7G" "mode=755" ]; };
    "/boot" = { device = "/dev/disk/by-uuid/2F71-8FE8"; fsType = "vfat"; };
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/49a55786-a043-400f-a6cb-3444ddda7975";
    fsType = "btrfs";
    options = [ "subvol=nix" "noatime" "compress-force=zstd" ];
  };

  fileSystems."/persistent" = {
    device = "/dev/disk/by-uuid/49a55786-a043-400f-a6cb-3444ddda7975";
    fsType = "btrfs";
    options = [ "subvol=persistent" "noatime" "compress-force=zstd" ];

    # Required for sops-nix:
    # /etc/ssh -> /persistent
    neededForBoot = true;
  };
}
