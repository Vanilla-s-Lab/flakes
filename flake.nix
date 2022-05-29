{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.nixpkgs.follows = "nixpkgs";
    nixos-cn.inputs.flake-utils.follows = "flake-utils";

    impermanence.url = "github:nix-community/impermanence";

    # https://github.com/icebox-nix/netkit.nix/blob/master/pkgs/data/chinalist/default.nix
    "icebox-nix/netkit.nix".url = "github:icebox-nix/netkit.nix";
    "icebox-nix/netkit.nix".flake = false;

    # https://github.com/serokell/deploy-rs
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    deploy-rs.inputs.utils.follows = "flake-utils";
  };

  outputs = { self, ... }@inputs: with inputs;
    let system = "x86_64-linux"; in
    rec {
      nixosConfigurations."NixOS-RoT" = nixosConfig;
      nixosConfig = nixpkgs.lib.nixosSystem rec {
        inherit system; specialArgs = { inherit inputs self system; };
        modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
          ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
          ++ [{ home-manager.extraSpecialArgs = { inherit inputs system; }; }]
          ++ [{ home-manager.useGlobalPkgs = true; }]
          ++ [{ nixpkgs.overlays = [ nur.overlay ]; }]
          ++ [ sops-nix.nixosModules.sops ]
          ++ [ nixos-cn.nixosModules.nixos-cn ]
          ++ [ impermanence.nixosModules.impermanence ];
      };
    };
}
