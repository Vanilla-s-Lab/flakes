{ lib, ... }:
{
  fileSystems = {
    "/" = { fsType = "tmpfs"; options = [ "defaults" "size=50%" "mode=755" ]; };
    "/boot" = { device = "/dev/disk/by-uuid/2F71-8FE8"; fsType = "vfat"; };
  };

  # https://itsfoss.com/create-swap-file-linux/
  boot.kernel.sysctl."vm.swappiness" = 25;

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

  # https://github.com/NixOS/nixpkgs/pull/146497/files
  systemd.generators = { systemd-gpt-auto-generator = "/dev/null"; };

  # https://opensource.com/article/19/2/swap-space-poll
  swapDevices = lib.singleton {
    device = "/swap/swapfile";
    size = 1024 * 4; # 4 GB
  };

  # https://discourse.nixos.org/t/how-do-i-set-up-a-swap-file/8323/7
  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/49a55786-a043-400f-a6cb-3444ddda7975";
    fsType = "btrfs";
    options = [ "subvol=swap" "noatime" "compress-force=zstd" ];
  };
}
