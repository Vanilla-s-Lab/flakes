{ ... }:
{
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub = {
    interval = "weekly";
    fileSystems = [ "/nix" "/persistent" ];
  };
}
