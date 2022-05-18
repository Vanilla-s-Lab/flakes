{ rustPlatform, fetchgit, cmake, ... }:
rustPlatform.buildRustPackage rec {
  pname = "quiche";
  version = "0.13.0";

  src = fetchgit {
    url = "https://github.com/cloudflare/${pname}";
    rev = "${version}";
    hash = "sha256-XOLsYaAOr6clH8YbR+mSXGs5uY5eM5fOD829e5nF4eA=";
  };

  cargoLock.lockFile = ./Cargo.lock;
  postPatch = "cp ${./Cargo.lock} Cargo.lock";

  nativeBuildInputs = [
    cmake
  ];
}
