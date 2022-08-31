{ callPackage, poetry2nix, fetchgit, python3, pkgs, ... }:
let generated = callPackage ../../../_sources/generated.nix { }; in
let aospdtgen = generated."aospdtgen"; in
poetry2nix.mkPoetryApplication {
  projectDir = fetchgit {
    url = "https://github.com/sebaubuntu-python/${aospdtgen.pname}";
    rev = "${aospdtgen.version}";

    postFetch = "cd $out && patch < ${./poetry.patch}";
    hash = "sha256-c+5ZjR06kiDEpYaHzbIqbZDfrdPXArrwvVTypZCGCYg=";
  };

  preferWheels = true;
}
