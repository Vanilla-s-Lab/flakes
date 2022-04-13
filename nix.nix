{ pkgs, inputs, self, ... }: with inputs;
{
  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Used for flake in root.
  programs.git.enable = true;

  # https://mirrors.bfsu.edu.cn/help/nix/
  nix.binaryCaches = [
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
    "https://nixos-cn.cachix.org/"
    "https://deploy-rs.cachix.org/"
    "https://across.cachix.org/"
  ];

  # https://github.com/cachix/install-nix-action
  nix.binaryCachePublicKeys = [
    "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
    "deploy-rs.cachix.org-1:M+ZN++7fdqZFeIsvJyqeQrgnAbgsPNuv8z93uAJO43w="
    "across.cachix.org-1:gbHoNiu6UQBGwgEF+zAA00ovBCn5ObAER4KPqGQVI9A="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.registry."nixpkgs-unfree".flake = nixpkgs-unfree;
}
