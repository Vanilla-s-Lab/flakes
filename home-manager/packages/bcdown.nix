{ rustPlatform, fetchgit, pkg-config, openssl, ... }:
rustPlatform.buildRustPackage rec {
  pname = "bcdown";
  version = "v0.2.2";

  src = fetchgit {
    url = "https://github.com/lihe07/bilibili_comics_downloader";
    rev = "${version}";
    hash = "sha256-PIMYpqY8gC6dvj73/itxwL22OyuFq7Lbvy8hpgHTIKI=";
  };

  cargoSha256 = "sha256-DMap2CUb5N7P9+kIRgDjUF9uR9disvG+8YaWqlptztw=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];
}
