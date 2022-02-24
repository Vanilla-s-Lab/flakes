{ lib, pkgs, config, ... }:
let myh2o_backup = "098ed3541f61e477d9c9185fad15605b91644dcc34819ac700585abc27fba113"; in
let Videos = "59682d0a8bc570a588c66fff6d2f6b03ef4afc5e9c2eac86ee770beafa61328f"; in
{
  # https://github.com/fish-shell/fish-shell
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

  # https://github.com/fish-shell/fish-shell
  programs.fish.enable = true;
  home.packages = [
    pkgs.nur.repos.linyinfeng.fishPlugins.git
    pkgs.nur.repos.linyinfeng.fishPlugins.bang-bang
    pkgs.fishPlugins.pisces
    pkgs.any-nix-shell

    # https://github.com/sharkdp/fd
    pkgs.fd
    # https://github.com/BurntSushi/ripgrep
    pkgs.ripgrep
  ];

  # https://github.com/jhillyerd/plugin-git
  home.activation."fishPlugins.git" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      ''fish -c "__git.init" || true'';

  # https://starship.rs/
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    line_break.disabled = true;
  };

  # https://github.com/ogham/exa
  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  # https://github.com/rose-pine/fish
  home.file.".config/fish/functions/rose_pine.fish".source =
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/fish/main/rose_pine.fish";
      hash = "sha256-RSC7d0x+m2FWtNyN8WmmHNcTn2gL6ZS5tRsc3KJB8Hc=";
    };

  home.activation."rose_pine-dawn" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      ''fish -c "rose_pine dawn" > /dev/null || true'';

  # https://github.com/haslersn/any-nix-shell
  programs.fish.interactiveShellInit =
    "any-nix-shell fish --info-right | source";

  # https://github.com/nix-community/nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # https://github.com/nix-community/nix-direnv/issues/137
  programs.direnv.nix-direnv.enableFlakes = true;

  home.file.".local/share/direnv/allow/${myh2o_backup}".text =
    "/persistent/Documents/myh2o_backup/.envrc";
  home.file.".local/share/direnv/allow/${Videos}".text =
    "/persistent/Videos/.envrc";

  # https://github.com/bennofs/nix-index
  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;

  # https://github.com/Mic92/nix-index-database/releases
  home.file.".cache/nix-index/files".source =
    pkgs.fetchurl {
      url = "https://github.com/Mic92/nix-index-database" +
        "/releases/download/2022-02-19/index-x86_64-linux";
      hash = "sha256-4n4x7lJM47/v/6Tc3kxbDKMqIhg9IEwGSs4Q2A1Ld8Q=";
    };
}
