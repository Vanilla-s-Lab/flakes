{ stdenv, fetchgit, meson, ninja, sassc, ... }:
stdenv.mkDerivation rec {
  pname = "adw-gtk3";
  version = "1.6";

  src = fetchgit {
    url = "https://github.com/lassekongo83/${pname}";
    rev = "v${version}";
    hash = "sha256-njTje36lOSvkXexSnigXqQnwheDCXHBJYWLZxp7m4xQ=";
  };

  nativeBuildInputs = [ meson ninja ];
  buildInputs = [ sassc ];
}
