{ pkgs, ... }:
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
{
  programs.neovim.enable = true;
  programs.neovim.package = pkgs.neovim-nightly;

  programs.neovim.plugins = with pkgs; [
    # https://github.com/NvChad/NvChad/blob/v1.0/lua/pluginList.lua#L243
    nur.repos.m15a.vimExtraPlugins.dashboard-nvim
  ];

  programs.neovim.extraConfig = ''
    " https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing
    set cpoptions-=_
  '';
}
