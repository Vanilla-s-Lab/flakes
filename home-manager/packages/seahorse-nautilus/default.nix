{ callPackage, stdenv, meson, pkg-config, cmake, gnome, gtk3, libcryptui, gcr, libnotify, gnupg, gpgme, python3, ninja, ... }:
let generated = callPackage ../../../_sources/generated.nix { }; in
stdenv.mkDerivation rec {
  pname = generated.seahorse-nautilus.pname;
  version = generated.seahorse-nautilus.version;

  src = generated.seahorse-nautilus.src;

  nativeBuildInputs = [
    meson
    pkg-config
    cmake
    ninja
  ];

  buildInputs = [
    gnome.nautilus
    gtk3
    libcryptui
    gcr
    libnotify

    gnupg
    (gpgme.dev.overrideAttrs (old: {
      # https://github.com/NixOS/nixpkgs/issues/177864
      patches = old.patches ++ [ ./remove-unknown-suffix.patch ];
    }))

    python3
  ];

  postPatch = ''
    patchShebangs meson/gpg_check_version.py
  '';

  # https://gitlab.gnome.org/GNOME/seahorse-nautilus/-/blob/master/meson_options.txt
  mesonFlags = [ "-Dnautilus-ext-dir=lib/nautilus/extensions-3.0" ];

  # Only need in `nixos-22.05` new gpg.
  patches = [ ./allow-gnupg-230.patch ];
}
