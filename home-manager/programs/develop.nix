{ pkgs, ... }:
{
  home.packages = [
    (pkgs.python3.withPackages (p: with p; [ pygobject3 ]))
  ];
}
