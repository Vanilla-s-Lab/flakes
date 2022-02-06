{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Used for flake in root.
  programs.git.enable = true;

  # Liya-Fedin's cachix for building Kotatogram.
  nix.settings.substituters = [
    "https://nixos-cn.cachix.org/"
    "https://ilya-fedin.cachix.org/"
    "https://kdna.cachix.org/"
    "https://cache.nixos.org/"
  ];

  # https://github.com/cachix/install-nix-action
  nix.settings.trusted-public-keys = [
    "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
    "ilya-fedin.cachix.org-1:QveU24a5ePPMh82mAFSxLk1P+w97pRxqe9rh+MJqlag="
    "kdna.cachix.org-1:xAkLlelk3u0frMsevzcDLsjGe6ifqXx8q+OrPkbmetI="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
}
