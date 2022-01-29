{
  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... }@inputs: with inputs;
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
      packages.nixosConfigurations."NixOS-RoT" = nixos.lib.nixosSystem rec {
        inherit system;
        modules = [ ./configuration.nix ];
      };
    });
}
