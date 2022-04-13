{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # https://github.com/NixOS/nixpkgs/pull/160115
    nixpkgs-jetbrains.url = "github:VergeDX/nixpkgs";

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

    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree";
    nixpkgs-unfree.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/VanCoding/nix-vscode-extension-manager
    nvem.url = "github:VanCoding/nix-vscode-extension-manager";
    nvem.inputs.flake-utils.follows = "flake-utils";
    # nvem.inputs.nixpkgs.follows = "nixpkgs";

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
        inherit system; specialArgs = { inherit inputs self; };
        modules = [ ./configuration.nix home-manager.nixosModules.home-manager ]
          ++ [{ home-manager.users."vanilla" = import ./home-manager/home.nix; }]
          ++ [{ home-manager.extraSpecialArgs = { inherit inputs system; }; }]
          ++ [{ home-manager.useGlobalPkgs = true; }]
          ++ [{ nixpkgs.overlays = [ nur.overlay ]; }]
          ++ [ sops-nix.nixosModules.sops ]
          ++ [ nixos-cn.nixosModules.nixos-cn ]
          ++ [ impermanence.nixosModules.impermanence ];
      };

      # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image_natively
      sdImage = raspi.config.system.build.sdImage;

      raspi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix" ] ++
          [{ sdImage.compressImage = false; }] # nix build .#raspi.config.system.build.sdImage -v -L
          ++ [ ./raspi/configuration.nix ./raspi/users.nix ] ++ [ ./services/smartdns.nix ] ++
          [ ./raspi/services/dhcpd4.nix ./raspi/services/hostapd.nix ./raspi/services/nodogsplash.nix ];

        specialArgs = { inherit inputs; };
      };

      deploy.nodes.raspi = {
        sshUser = "root";
        hostname = "192.168.3.151";

        profiles.system.path =
          deploy-rs.lib."${raspi.pkgs.system}".activate.nixos
            raspi;

        fastConnection = true;
      };
    };
}
