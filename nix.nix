{ pkgs, inputs, self, ... }: with inputs;
{
  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # https://nixos.org/manual/nix/unstable/command-ref/conf-file.html
  nix.settings.keep-going = true;

  programs.git.enable = true;
  # https://stackoverflow.com/questions/71876704
  programs.git.config = {
    safe.directory = "/persistent/Projects/flakes";
  };

  # https://mirrors.bfsu.edu.cn/help/nix/
  nix.binaryCaches = [
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
    "https://nixos-cn.cachix.org/"
    "https://nix-community.cachix.org/"
  ];

  # https://github.com/cachix/install-nix-action
  nix.binaryCachePublicKeys = [
    "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # Used for impure `<nixpkgs>`.
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
