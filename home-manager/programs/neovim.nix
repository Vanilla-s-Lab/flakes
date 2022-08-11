{ ... }:
{
  programs.neovim.enable = true;
  programs.neovim.extraConfig = ''
    " https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing
    set cpoptions-=_
  '';
}
