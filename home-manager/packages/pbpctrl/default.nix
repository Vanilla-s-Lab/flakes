{ rustPlatform, generated, pkg-config, dbus, protobuf, ... }:
rustPlatform.buildRustPackage {

  pname = generated."\"qzed/pbpctrl\"".pname;
  src = generated."\"qzed/pbpctrl\"".src;
  version = generated."\"qzed/pbpctrl\"".version;

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ dbus ];

  PROTOC = "${protobuf}/bin/protoc";
}
