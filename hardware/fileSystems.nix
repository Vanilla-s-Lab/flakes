{ lib, ... }:
{
  fileSystems = {
    "/" = { fsType = "tmpfs"; options = [ "defaults" "size=50%" "mode=755" ]; };
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

  fileSystems."/Games" = {
    device = "/dev/disk/by-label/Games";
    fsType = "ext4";
  };

  fileSystems."/Repos" = {
    device = "/dev/disk/by-label/Repos";
    fsType = "ext4";
  };

  # https://superuser.com/questions/1271645/how-do-you-declare-a-bind-mount-in-nixos
  fileSystems."/etc/NetworkManager/system-connections" = {
    device = "/persistent/etc/NetworkManager/system-connections";
    options = lib.singleton "bind";
  };

  # https://github.com/NixOS/nixpkgs/pull/146497/files
  systemd.generators = { systemd-gpt-auto-generator = "/dev/null"; };

  # https://github.com/nix-community/impermanence
  programs.fuse.userAllowOther = true;
}
