{ callPackage, stdenv, autoconf, gettext, libtool, automake, pkg-config, gnome, glib, gtk3, ... }:
let generated = callPackage ../../_sources/generated.nix { }; in
stdenv.mkDerivation {
  pname = generated.nautilus-bluetooth.pname;
  version = generated.nautilus-bluetooth.version;

  src = generated.nautilus-bluetooth.src;

  configurePhase = ''
    ./bootstrap --noconfigure
    ./configure
  '';

  nativeBuildInputs = [
    autoconf
    libtool
    gettext
    automake

    pkg-config
  ];

  buildInputs = [
    # gnome.glib
    glib

    gnome.nautilus

    # gnome.gtk3
    gtk3

    gnome.gnome-bluetooth
  ];

  patchPhase = ''
    # https://stackoverflow.com/questions/584894/environment-variable-substitution-in-sed
    sed -i 's@$(NAUTILUS_EXTENSION_DIR)@'"$out"'@' src/Makefile.am
  '';

  installPhase = ''
    sed -i 's@/usr/@@g' Makefile
    make install-strip
  '';
}
