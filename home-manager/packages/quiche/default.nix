{ rustPlatform, fetchgit, cmake, lib, ... }:
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

  # https://github.com/curl/curl/blob/master/docs/HTTP3.md
  cargoBuildFlags = "--package ${pname}";
  buildFeatures = [ "ffi" "pkg-config-meta" "qlog" ];

  # https://doc.rust-lang.org/cargo/guide/build-cache.html
  spec = rustPlatform.cargoBuildHook.rustTargetPlatformSpec;
  installPhase = ''
    mkdir $out
    echo "# quiche" >> $out/quiche.pc
    echo "" >> $out/quiche.pc

    cp -r quiche/include $out/include
    echo "includedir=$out/include" >> $out/quiche.pc

    mkdir $out/lib
    cp target/${spec}/release/libquiche.{a,so} $out/lib
    echo "libdir=$out/lib" >> $out/quiche.pc

    echo "" >> $out/quiche.pc
    echo '${lib.fileContents ./quiche.pc}' >> $out/quiche.pc
  '';
}
