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
}
