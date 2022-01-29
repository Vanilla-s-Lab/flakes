{ pkgs, lib, ... }:
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    import = lib.singleton (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/alacritty/main/rose-pine-dawn.yml";
      sha256 = "sha256-/1y/sYIugR27QgbM2rG4WganTPbdqbAgnbrjkDXIgUg=";
    });

    font = {
      normal = { family = "Hack Nerd Font"; style = "Regular"; };
      bold = { family = "Hack Nerd Font"; style = "Bold"; };
      italic = { family = "Hack Nerd Font"; style = "Italic"; };
      size = 11.0;
    };
  };
}
