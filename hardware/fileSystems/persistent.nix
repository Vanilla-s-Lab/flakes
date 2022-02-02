{ ... }:
{
  fileSystems."/persistent" = {
    device = "/dev/disk/by-uuid/49a55786-a043-400f-a6cb-3444ddda7975";
    fsType = "btrfs";
    options = [ "subvol=persistent" "noatime" "compress-force=zstd" ];

    neededForBoot = true;
  };
}
