{ nixpkgs, lib, ... }:
{
  imports = [ "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix" ]
    ++ [ ./users.nix ];
}
