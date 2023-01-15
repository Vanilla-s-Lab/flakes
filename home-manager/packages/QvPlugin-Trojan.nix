{ stdenv, fetchgit, cmake, libsForQt5, boost, ... }:
stdenv.mkDerivation rec {
  pname = "QvPlugin-Trojan";
  version = "v3.0.0";

  src = fetchgit {
    url = "https://github.com/Qv2ray/${pname}";
    rev = "${version}";
    hash = "sha256-yMrvcd9QTbWuAPKt3VOYvvhbZFOowx+hsiQkZ/wdjQM=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = [ boost ];
}
