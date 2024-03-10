{ pkgs, inputs, self, ... }: with inputs;
{
  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.git.enable = true;
  # https://stackoverflow.com/questions/71876704
  programs.git.config = {
    safe.directory = "/persistent/Projects/flakes";
  };

  # https://mirrors.bfsu.edu.cn/help/nix/
  nix.settings.substituters = [
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
  ];

  # https://github.com/cachix/install-nix-action
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];

  # Used for impure `<nixpkgs>`.
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
