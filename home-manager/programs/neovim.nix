{ pkgs, ... }:
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
{
  programs.neovim.enable = true;
  programs.neovim.package = pkgs.neovim-nightly;

  programs.neovim.extraConfig = ''
    " https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing
    set cpoptions-=_
  '';
}
