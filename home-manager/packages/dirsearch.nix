{ python3Packages, ... }:
python3Packages.buildPythonPackage rec {
  pname = "dirsearch";
  version = "0.4.2";

  format = "wheel";

  # https://nixos.wiki/wiki/Packaging/Python#install_binary_release
  src = python3Packages.fetchPypi rec {
    inherit pname version format;

    sha256 = "sha256-2bt/eC79pjsf03gtdMBd6ZAms4mkA2UTvoESy+fIDoU=";
    dist = python;
    python = "py3";
  };

  propagatedBuildInputs = with python3Packages;
    [ certifi urllib3 cryptography chardet ];
}
