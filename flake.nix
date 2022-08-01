{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # https://github.com/NixOS/nixpkgs/commits/nixos-22.05/nixos/modules/services/hardware/udev.nix
    nixpkgs-udev-fix.url = "github:nixos/nixpkgs/89ace3967e0fefef19666366d64d315bae9b8f19";

    # https://github.com/NixOS/nixpkgs/pull/133672/files
    nixpkgs-playwright-chromium.url = "github:jlesquembre/nixpkgs/playwright";
    nixpkgs-playwright-chromium.flake = false;

    nix-channel.url = "https://channels.nixos.org/nixos-22.05/nixexprs.tar.xz";

    home-manager.url = "github:nix-community/home-manager/release-22.05";
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

    # https://github.com/serokell/deploy-rs
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs: with inputs;
    let system = "x86_64-linux"; in
    rec {
      nixosConfigurations."NixOS-RoT" = nixosConfig;
      nixosConfig = nixpkgs.lib.nixosSystem rec {
        inherit system; specialArgs = { inherit inputs self system pkgsUnstable; };
        modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
          ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
          ++ [{ home-manager.extraSpecialArgs = { inherit inputs system; }; }]
          ++ [{ home-manager.useGlobalPkgs = true; }]
          ++ [{ nixpkgs.overlays = [ nur.overlay ]; }]
          ++ [ sops-nix.nixosModules.sops ]
          ++ [ nixos-cn.nixosModules.nixos-cn ]
          ++ [ impermanence.nixosModules.impermanence ];
      };

      pkgs = import nixpkgs { inherit system; };
      pkgsUnstable = import nixpkgs-unstable
        { inherit system; config.allowUnfree = true; };
    };
}
