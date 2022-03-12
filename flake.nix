{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    Vanilla.url = "github:Vanilla-s-Lab/Vanilla";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.flake-utils.follows = "flake-utils";
    nixos-cn.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree";
    nixpkgs-unfree.inputs.nixpkgs.follows = "nixpkgs";

    ilya-fedin = {
      url = "github:ilya-fedin/nur-repository";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs: with inputs;
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: rec {
      pkgs = import nixpkgs { inherit system; };
      pkgsUnstable = import nixpkgs-unstable ({ inherit system; }
        // { config.allowUnfree = true; });

      packages.nixosConfigurations."NixOS-RoT" = nixosConfig;

      nixosConfig = nixpkgs.lib.nixosSystem rec {
        inherit system; specialArgs = { inherit inputs self pkgsUnstable; };
        modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
          ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
          ++ [{ home-manager.extraSpecialArgs = { inherit inputs system pkgsUnstable; }; }]
          ++ [{ home-manager.useGlobalPkgs = true; }]
          ++ [{ nixpkgs.overlays = [ nur.overlay ]; }]
          ++ [ sops-nix.nixosModules.sops ]
          ++ [ nixos-cn.nixosModules.nixos-cn ]
          ++ [ impermanence.nixosModules.impermanence ];
      };
    });
}
