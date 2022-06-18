{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;

    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.nixpkgs.follows = "nixpkgs";
    nixos-cn.inputs.flake-utils.follows = "flake-utils";

    impermanence.url = "github:nix-community/impermanence";

    # https://github.com/icebox-nix/netkit.nix/blob/master/pkgs/data/chinalist/default.nix
    "icebox-nix/netkit.nix".url = "github:icebox-nix/netkit.nix";
    "icebox-nix/netkit.nix".flake = false;

    # https://github.com/serokell/deploy-rs
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.flake-compat.follows = "flake-compat";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    deploy-rs.inputs.utils.follows = "flake-utils";

    # https://github.com/ArkToria/ACross
    ACross.url = "github:ArkToria/ACross";
    ACross.inputs.flake-utils.follows = "flake-utils";
    ACross.inputs.nixpkgs.follows = "nixpkgs";
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
          ++ [{ nixpkgs.overlays = [ nur.overlay ACross.overlay ]; }]
          ++ [ sops-nix.nixosModules.sops ]
          ++ [ nixos-cn.nixosModules.nixos-cn ]
          ++ [ impermanence.nixosModules.impermanence ];
      };

      pkgs = import nixpkgs { inherit system; };
      pkgsOld = import nixpkgs-old { inherit system; };
      pkgsMaster = import nixpkgs-master { inherit system; };
    };
}
