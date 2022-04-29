{ stdenv, name, ... }:
stdenv.mkDerivation {
  inherit name;
  src = ../../fonts;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/
    cp $src/$name/*.ttc $out/share/fonts/opentype/
  '';
}
