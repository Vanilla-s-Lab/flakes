{ callPackage, rustPlatform, ... }:
let generated = callPackage ../../../_sources/generated.nix { }; in
rustPlatform.buildRustPackage {
  pname = generated.hwatch.pname;
  version = generated.hwatch.version;

  src = generated.hwatch.src;

  cargoLock.lockFile = ./Cargo.lock;
  postPatch = "cp ${./Cargo.lock} Cargo.lock";
}
