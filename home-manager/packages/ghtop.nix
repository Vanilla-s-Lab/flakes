{ callPackage, python3Packages, fetchgit, ... }:
let dashing = callPackage ./dashing.nix { }; in
python3Packages.buildPythonPackage rec {
  pname = "ghtop";
  version = "051b576";

  src = fetchgit {
    url = "https://github.com/nat/${pname}";
    rev = "${version}89f6b6a51fc874675a586006df2142556";
    hash = "sha256-u6z8yd+HM8luSBHxvDcwRY1dVWyikQbkhh6auiRlqus=";
  };

  # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md
  propagatedBuildInputs = with python3Packages; [ rich enlighten fastcore emoji dashing ];
}
