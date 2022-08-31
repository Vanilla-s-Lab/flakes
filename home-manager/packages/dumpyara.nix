{ callPackage, poetry2nix, fetchgit, ... }:
let generated = callPackage ../../_sources/generated.nix { }; in
let dumpyara = generated."dumpyara"; in
poetry2nix.mkPoetryApplication {
  projectDir = fetchgit {
    url = "https://github.com/sebaubuntu-python/${dumpyara.pname}";
    rev = "${dumpyara.version}";
    hash = "sha256-xi5j2kjIGyWj2s51nQR6TJKkKdiUqs+TJCZNS2efIrc=";
  };

  preferWheels = true;
}
