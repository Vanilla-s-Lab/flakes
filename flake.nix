{
  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    Vanilla.url = "github:Vanilla-s-Lab/Vanilla";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixos";

    nur.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixos";

    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.flake-utils.follows = "flake-utils";
    nixos-cn.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, ... }@inputs: with inputs;
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
      packages.nixosConfigurations."NixOS-RoT" = nixos.lib.nixosSystem rec {
        inherit system; specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
          ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
          ++ [{ home-manager.extraSpecialArgs = { inherit inputs system; }; }]
          ++ [{ home-manager.useGlobalPkgs = true; }]
          ++ [{ nixpkgs.overlays = [ nur.overlay ]; }]
          ++ [ sops-nix.nixosModules.sops ]
          ++ [ nixos-cn.nixosModules.nixos-cn ];
      };
    });
}
