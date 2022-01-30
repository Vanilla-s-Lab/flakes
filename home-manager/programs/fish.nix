{ pkgs, lib, ... }:
{
  programs.fish.enable = true;
  home.packages = [
    pkgs.nur.repos.linyinfeng.fishPlugins.git
  ];

  home.activation."fishPlugins.git" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      "fish -c \"__git.init\" && true";
}
