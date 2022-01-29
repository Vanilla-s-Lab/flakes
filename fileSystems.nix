{ ... }:
{
  fileSystems."/" =
    {
      device = "none";
      fsType = "tmpfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/2F71-8FE8";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/49a55786-a043-400f-a6cb-3444ddda7975";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/persistent" =
    {
      device = "/dev/disk/by-uuid/49a55786-a043-400f-a6cb-3444ddda7975";
      fsType = "btrfs";
      options = [ "subvol=persistent" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/1b07ef58-fa1b-4e5e-a394-7a07a9229f07"; }];
}
