{ ... }:
{
  # https://nixos.wiki/wiki/VirtualBox
  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
