{ python3Packages, fetchgit, ... }:
python3Packages.buildPythonPackage rec {
  pname = "dirsearch";
  version = "24b7bc3";

  # https://github.com/maurosoria/dirsearch/issues/899
  # https://github.com/maurosoria/dirsearch/pull/1027

  src = fetchgit {
    url = "https://github.com/maurosoria/${pname}";
    rev = "${version}75a196de7e709edb0d16ed06fe198ef2e";
    hash = "sha256-zkalX3Xa6t3jPhUPBaXgsLckrhbrn8ZOvE9I0T/BatY=";
  };

  patchPhase = ''
    # sed -i s@open("@open("${src}/@g setup.py
    sed -i s@requirements@${src}/requirements@g setup.py
  '';

  # propagatedBuildInputs = with python3Packages;
  #   [ certifi urllib3 cryptography chardet ];

  meta = { broken = true; };
}
