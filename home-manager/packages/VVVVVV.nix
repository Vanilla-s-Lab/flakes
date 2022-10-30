{ stdenv, generated, cmake, SDL2, SDL2_mixer, fetchurl, ... }:
stdenv.mkDerivation rec {
  pname = generated."VVVVVV".pname;
  version = generated."VVVVVV".version;

  src = generated."VVVVVV".src;

  nativeBuildInputs = [ cmake ];
  cmakeDir = "../desktop_version";

  buildInputs = [ SDL2 SDL2_mixer ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./${pname} $_

    cp ${data_zip} $_/data.zip
  '';

  data_zip = fetchurl {
    url = "https://thelettervsixtim.es/makeandplay/data.zip";
    hash = "sha256-HaTXWPVFHTewD/6400AgmA2lQmVH8cmsUyYW/jO4TLM=";
  };
}
