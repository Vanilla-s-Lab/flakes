{
  inputs = {
    # https://github.com/NixOS/nixpkgs/pull/196738
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-channel.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cn.url = "github:nixos-cn/flakes";
    nixos-cn.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    # https://github.com/icebox-nix/netkit.nix/blob/master/pkgs/data/chinalist/default.nix
    "icebox-nix/netkit.nix".url = "github:icebox-nix/netkit.nix";
    "icebox-nix/netkit.nix".flake = false;

    # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  outputs = { self, ... }@inputs: with inputs;
    let system = "x86_64-linux"; in
    rec {
      nixosConfigurations."NixOS-RoT" = nixosConfig;
      # https://github.com/nix-community/neovim-nightly-overlay
      nixosConfig = let overlays = [ nur.overlay ]; in
        nixpkgs.lib.nixosSystem rec {
          inherit system; specialArgs = { inherit inputs self; };
          modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
            ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
            ++ [{ home-manager.extraSpecialArgs = { inherit inputs system generated; }; }]
            ++ [{ home-manager.useGlobalPkgs = true; }]
            ++ [{ nixpkgs.overlays = overlays; }]
            ++ [ sops-nix.nixosModules.sops ]
            ++ [ nixos-cn.nixosModules.nixos-cn ]
            ++ [ impermanence.nixosModules.impermanence ]
            ++ [ lanzaboote.nixosModules.lanzaboote ];
        };

      pkgs = import nixpkgs { inherit system; };
      generated = pkgs.callPackage ./_sources/generated.nix { };
    };
}
