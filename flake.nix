{
  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... }@inputs: with inputs; {
    nixosConfigurations."NixOS-RoT" = nixos.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
