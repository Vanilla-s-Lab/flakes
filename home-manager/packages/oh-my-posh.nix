{ callPackage, buildGoModule, ... }:
let generated = callPackage ../../_sources/generated.nix { }; in
buildGoModule {
  pname = generated.oh-my-posh.pname;
  version = generated.oh-my-posh.version;

  src = generated.oh-my-posh.src;

  vendorSha256 = "sha256-iBVehyfJ2WX/nSBbXeOD0ozjLSVn5LKDNgbYVopIr4w=";
  modRoot = "./src";
}
