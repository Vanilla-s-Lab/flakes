{ pkgs, inputs, self, ... }: with inputs;
{
  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  programs.git.enable = true;
  # https://stackoverflow.com/questions/71876704
  programs.git.config = {
    safe.directory = "/persistent/Projects/flakes";
  };

  # https://mirrors.bfsu.edu.cn/help/nix/
  nix.binaryCaches = [
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
    "https://nixos-cn.cachix.org/"
    "https://nixosimages.cachix.org/"
    "https://across.cachix.org/"
  ];

  # https://github.com/cachix/install-nix-action
  nix.binaryCachePublicKeys = [
    "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
    "nixosimages.cachix.org-1:/sgrtqsOnoD0piDCi3XE08jw+IkPslY6iovVbDRZYoQ="
    "across.cachix.org-1:gbHoNiu6UQBGwgEF+zAA00ovBCn5ObAER4KPqGQVI9A="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];

  # Used for impure `<nixpkgs>`.
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
