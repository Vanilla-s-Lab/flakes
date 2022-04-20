{ nixpkgs, lib, ... }:
{
  imports = [ "${nixpkgs}/nixos/modules/virtualisation/azure-image.nix" ]
    ++ [ ./users.nix ];
}
