{ python3Packages, fetchgit, ... }:
python3Packages.buildPythonPackage rec {
  pname = "dashing";
  version = "9f4d400";

  src = fetchgit {
    url = "https://github.com/hemanthmalla/${pname}";
    rev = "${version}a1e95c3093170710716233b1eefe5760a";
    hash = "sha256-EEd/IbSUHg8lCjpZhb8/KQAaaB71+IN+U6CzbPpVNDo=";
  };

  # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md
  propagatedBuildInputs = with python3Packages; [ blessed ghapi ];
}
