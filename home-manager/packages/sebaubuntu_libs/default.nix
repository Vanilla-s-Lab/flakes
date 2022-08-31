{ callPackage, poetry2nix, fetchgit, ... }:
let generated = callPackage ../../../_sources/generated.nix { }; in
let src = generated."sebaubuntu_libs"; in
poetry2nix.mkPoetryApplication {
  projectDir = fetchgit {
    url = "https://github.com/sebaubuntu-python/${src.pname}";
    rev = "${src.version}";

    postFetch = "cd $out && patch < ${./certifi.patch}";
    hash = "sha256-4SR1N0tI/nbgAoF3xMJd2xCYyR8nKLL4Q5jwn5yeIp0=";
  };
}
