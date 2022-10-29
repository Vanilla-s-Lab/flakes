{ callPackage, python3Packages, generated, ... }:
let pattern = callPackage ./pattern.nix { }; in
python3Packages.buildPythonPackage {
  pname = generated."grammaticommit".pname;
  version = generated."grammaticommit".version;

  src = generated."grammaticommit".src;
  dontPatchShebangs = true;

  propagatedBuildInputs = [ pattern ] ++
    (with python3Packages; [ termcolor ]);
}
