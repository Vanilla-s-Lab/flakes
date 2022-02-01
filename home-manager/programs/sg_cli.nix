{ pkgs, ... }:
{
  home.packages = [
    pkgs.nodePackages.clipboard-cli
    pkgs.xsel

    (pkgs.rustPlatform.buildRustPackage rec {
      pname = "sg_cli";
      version = "41e87fa";

      src = pkgs.fetchgit {
        url = "https://github.com/Vanilla-s-Lab/sg_cli";
        rev = "${version}457f78119c56024b037956edd475124dc";
        hash = "sha256-loI9WoCiuQMAfFqNSE4JlysgTFomxkBTTlgz/RsxVP0=";
      };

      # cargoSha256 = "";
      cargoHash = "sha256-Yni01W7nh3oa+A+5Weuh397nucZaYjz/kJQ6HEnERXE=";
    })
  ];
}
