{ stdenv, ... }:
stdenv.mkDerivation rec {
  name = "Helvetica";
  src = ../../fonts;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/
    cp $src/$name/*.ttc $out/share/fonts/opentype/
  '';
}
