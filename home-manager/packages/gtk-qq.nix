{ rustPlatform
, fetchgit
, pkg-config
, openssl
, protobuf
, glib
, cairo
, pango
, gdk-pixbuf
, gobject-introspection
, gtk4
, libadwaita
, rust-bin
, meson
, ninja
, libxml2
, sqlite
, wrapGAppsHook4
, pkgs
, ...
}:
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
rustPlatform.buildRustPackage rec {
  pname = "gtk-qq";
  version = "v0.2.0";

  src = generated."\"lomirus/gtk-qq\"".src;

  cargoSha256 = "sha256-ww3NTDJaaQyeE1dytsH+w8eB2RqmC0V/WKXzvbbradI=";

  nativeBuildInputs = [
    pkg-config
    rust-bin.nightly.latest.default
    meson
    glib.dev
    ninja
    libxml2
    wrapGAppsHook4
  ];

  buildInputs = [
    openssl
    glib
    cairo
    pango
    gdk-pixbuf
    gobject-introspection
    gtk4
    libadwaita
    sqlite
  ];

  PROTOC = "${protobuf}/bin/protoc";

  # https://github.com/lomirus/gtk-qq#setup
  configurePhase = ''
    meson setup builddir
    meson compile -C builddir
  '';

  dontUseNinjaBuild = true;
  dontUseNinjaInstall = true;

  # https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=gtk-qq-git
  postInstall = ''
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp ${generated."\"gtk-qq-git\"".src}/gtk-qq.png $_

    mkdir -p $out/share/applications
    cp ${generated."\"gtk-qq-git\"".src}/gtk-qq.desktop $_
  '';
}
