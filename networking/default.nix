{ ... }:
{
  imports = [
    ./hostname.nix
    ./domain.nix
    ./networkmanager/default.nix
    ./proxy.nix
  ];
}
