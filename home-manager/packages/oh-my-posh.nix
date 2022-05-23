{ callPackage, buildGoModule, ... }:
let generated = callPackage ../../_sources/generated.nix { }; in
buildGoModule {
  pname = generated.oh-my-posh.pname;
  version = generated.oh-my-posh.version;

  src = generated.oh-my-posh.src;

  vendorSha256 = "sha256-trG+w+xUlfsBkMfkM7vRxO41vXdymPFp5IYILR7hlQc=";
  modRoot = "./src";
}
