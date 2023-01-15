{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    nix-channel.url = "https://channels.nixos.org/nixos-22.11/nixexprs.tar.xz";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
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
  };

  outputs = { self, ... }@inputs: with inputs;
    let system = "x86_64-linux"; in
    rec {
      nixosConfigurations."NixOS-RoT" = nixosConfig;
      # https://github.com/nix-community/neovim-nightly-overlay
      nixosConfig = let overlays = [
        nur.overlay
      ]; in
        nixpkgs.lib.nixosSystem rec {
          inherit system; specialArgs = { inherit inputs self; };
          modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
            ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
            ++ [{ home-manager.extraSpecialArgs = { inherit inputs system generated; }; }]
            ++ [{ home-manager.useGlobalPkgs = true; }]
            ++ [{ nixpkgs.overlays = overlays; }]
            ++ [ sops-nix.nixosModules.sops ]
            ++ [ nixos-cn.nixosModules.nixos-cn ]
            ++ [ impermanence.nixosModules.impermanence ];
        };

      pkgs = import nixpkgs { inherit system; };
      generated = pkgs.callPackage ./_sources/generated.nix { };
    };
}
