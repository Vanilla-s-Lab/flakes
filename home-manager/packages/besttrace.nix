{ stdenvNoCC, fetchurl, unzip, autoPatchelfHook, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "besttrace";
  version = "V1.2.0";

  src = fetchurl {
    url = "https://cdn.ipip.net/17mon/${pname}4linux.zip";
    hash = "sha256-b3WcCchCSVZsR8WrKyAB9YGzIhUJucqGBua4C+3Mquc=";
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];

  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $_
    chmod +x $_/${pname}
  '';
}
