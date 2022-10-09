{ callPackage, stdenv, cmake, gettext, gnome, generated, ... }:
stdenv.mkDerivation {
  pname = generated.nautilus-admin.pname;
  version = generated.nautilus-admin.version;

  src = generated.nautilus-admin.src;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ gettext ];

  cmakeFlags = [ "-Wno-deprecated" ];

  patchPhase = ''
    sed -i 's@/usr/bin/nautilus@${gnome.nautilus}/bin/nautilus@g' CMakeLists.txt
    sed -i 's@/usr/bin/gedit@${gnome.gedit}/bin/gedit@g' CMakeLists.txt
  '' + ''
    sed -i 's@/usr/@usr/@g' CMakeLists.txt
  '' + ''
    # https://fostips.com/open-as-administrator-ubuntu-21-04-fix/
    sed -i 's/ subprocess/ subprocess, locale/g' extension/nautilus-admin.py
    sed -i 's/locale, //g' extension/nautilus-admin.py
  '';
}
