{ callPackage, rustPlatform, pkg-config, openssl, ... }:
let generated = callPackage ../../_sources/generated.nix { }; in
rustPlatform.buildRustPackage {
  pname = generated.nushell.pname;
  version = generated.nushell.version;

  src = generated.nushell.src;

  # cargoSha256 = "sha256-Vd8R9EsO52q840HqRzc37PirZZyTZr+Bnow5qHEacJ0=";
  # cargoSha256 = "sha256-j+d8DjPyGvrclx3DTo794qj5t8Rtnhmgv7pjwc7800A=";
  cargoSha256 = "sha256-A2RJoU2hHcN6DfBQ+cPECtoVnrxlEHHlOV9bLqQE8VU=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false;
}
