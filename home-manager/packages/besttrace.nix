{ stdenvNoCC, fetchurl, unzip, autoPatchelfHook, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "besttrace";
  version = "V1.2.0";

  src = fetchurl {
    url = "https://cdn.ipip.net/17mon/${pname}4linux.zip";
    hash = "sha256-d1aFDEBeqQ4ZwVEi2JE0yIo7wzoz3zEVWNoNuzdBFdo=";
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
