{ pkgs, lib, config, ... }:
{
  programs.fish.enable = true;
  home.packages = [
    pkgs.nur.repos.linyinfeng.fishPlugins.git
    pkgs.nur.repos.linyinfeng.fishPlugins.bang-bang
  ] ++ [ pkgs.fishPlugins.pisces ];

  home.activation."fishPlugins.git" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      "fish -c \"__git.init\" && true";

  home.file.".config/fish/functions/rose_pine.fish".source =
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/fish/main/rose_pine.fish";
      hash = "sha256-RSC7d0x+m2FWtNyN8WmmHNcTn2gL6ZS5tRsc3KJB8Hc=";
    };

  programs.fish.interactiveShellInit = ''
    rose_pine dawn > /dev/null
  '';
}
