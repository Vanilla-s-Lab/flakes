{ callPackage, stdenv, meson, pkg-config, glib, ninja, python3, gtk3, ... }:
let generated = callPackage ../../_sources/generated.nix { }; in
stdenv.mkDerivation rec {
  pname = generated.nautilus-git.pname;
  version = generated.nautilus-git.version;

  src = generated.nautilus-git.src;

  nativeBuildInputs = [ meson pkg-config ninja ];
  buildInputs = [ glib python3 gtk3 ];
  patchPhase = "patchShebangs meson_post_install.py";
}
