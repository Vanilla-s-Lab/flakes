{ lib, pkgs, ... }:
let fromGH = owner: repo: lib.generators.toINI { } {
  "Projects/${repo}" = {
    "checkout" = "git clone 'git@github.com:${owner}/${repo}.git' '${repo}'";
  };
}; in
{
  home.packages = [ pkgs.mr ];
  home.file.".mrconfig".text = lib.strings.concatStringsSep "\n" [
    (fromGH "Vanilla-s-Lab" "flakes")
    (fromGH "NixOS" "nixos-artwork")
    (fromGH "NixOS" "nixpkgs")
    (fromGH "VergeDX" "masm")
  ];
}
