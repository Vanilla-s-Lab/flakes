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
    "https://ilya-fedin.cachix.org/"
    "https://cache.nixos.org/"
  ];

  # https://github.com/cachix/install-nix-action
  nix.settings.trusted-public-keys = [
    "ilya-fedin.cachix.org-1:QveU24a5ePPMh82mAFSxLk1P+w97pRxqe9rh+MJqlag="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
}
