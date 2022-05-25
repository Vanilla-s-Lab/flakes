{ callPackage, rustPlatform, pkg-config, openssl, ... }:
let generated = callPackage ../../../_sources/generated.nix { }; in
rustPlatform.buildRustPackage {
  pname = generated.nushell.pname;
  version = generated.nushell.version;

  src = generated.nushell.src;

  cargoSha256 = "sha256-Vd8R9EsO52q840HqRzc37PirZZyTZr+Bnow5qHEacJ0=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  patches = [ ./table-add-flag-w.patch ];
  doCheck = false;
}
