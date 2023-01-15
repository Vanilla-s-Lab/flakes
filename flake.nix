{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    rust-overlay.url = "github:oxalica/rust-overlay";

    nix-channel.url = "https://channels.nixos.org/nixos-23.11/nixexprs.tar.xz";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # https://discourse.nixos.org/t/nixos-rebuild-fails-with-current-configuration/27678/3
    home-manager.url = "github:nix-community/home-manager/release-23.11";
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

    # https://github.com/nix-community/nix-vscode-extensions#with-flakes
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  outputs = { self, ... }@inputs: with inputs;
    let system = "x86_64-linux"; in
    rec {
      nixosConfigurations."NixOS-RoT" = nixosConfig;
      # https://github.com/nix-community/neovim-nightly-overlay
      nixosConfig = let overlays = [ nur.overlay rust-overlay.overlays.default ]; in
        nixpkgs.lib.nixosSystem rec {
          inherit system; specialArgs = { inherit inputs self system; };
          modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
            ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
            ++ [{ home-manager.extraSpecialArgs = { inherit inputs system generated; }; }]
            ++ [{ home-manager.extraSpecialArgs = { inherit nix-vscode-extensions; }; }]
            ++ [{ home-manager.useGlobalPkgs = true; }]
            ++ [{ nixpkgs.overlays = overlays; }]
            ++ [ sops-nix.nixosModules.sops ]
            ++ [ impermanence.nixosModules.impermanence ]
            ++ [ lanzaboote.nixosModules.lanzaboote ];
        };

      pkgs = import nixpkgs { inherit system; };
      generated = pkgs.callPackage ./_sources/generated.nix { };
    };
}
