{ callPackage, python3Packages, lib, gnome, pango, harfbuzz, gdk-pixbuf, atk, vte, gtk3, glib, generated, ... }:
python3Packages.buildPythonPackage rec {
  pname = generated.nautilus-terminal.pname;
  version = generated.nautilus-terminal.version;

  src = generated.nautilus-terminal.src;

  propagatedBuildInputs = [
    python3Packages.psutil
  ];

  checkInputs = [
    python3Packages.pygobject3
  ];

  # Expose ouside to used as `propagatedBuildInputs` in pkgs.nautilus overrides.
  giLib = (with gnome; [ nautilus /* gtk3 */ pango.out harfbuzz gdk-pixbuf atk vte gtk3 ]);

  # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/gnome.section.md#onto-wrapgappshook-ssec-gnome-hooks=
  GI_TYPELIB_PATH = "${lib.makeSearchPath "lib/girepository-1.0" giLib}";

  # glib-compile-schemas
  buildInputs = [ glib.dev ];

  pyDir = with python3Packages.python.sourceVersion; "python" + major + "." + minor;

  installPhase = ''
    pipInstallPhase && export HOME=$out
    $out/bin/nautilus-terminal --install-user

    # Assure `site-packages/nautilus_terminal/schemas/gschemas.compiled` exists.
    glib-compile-schemas $out/lib/${pyDir}/site-packages/nautilus_terminal/schemas
  '';
}
