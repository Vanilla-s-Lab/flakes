{ stdenv, fetchgit, yajl, pkg-config, gtkmm3, curl, ... }:
stdenv.mkDerivation rec {
  pname = "SamRewritten";
  version = "202008";

  src = fetchgit {
    url = "https://github.com/PaulCombal/${pname}";
    rev = "refs/tags/${version}"; # NixOS/nix/issues - #3687
    hash = "sha256-q3kDuZdnWw1Nfu3hVDD8XKJzbmwlx/lafJfhziVYKhw=";
  };

  buildInputs = [ yajl gtkmm3 curl ];
  nativeBuildInputs = [ pkg-config ];

  patchPhase = ''
    sed -i 's/-ldl/-ldl -lpthread/g' Makefile
    # sed -i '4 {s/^/# /}' Makefile && cat $_
  '';

  buildPhase = "make -j $(nproc)";
  makeFlags = [ "DESTDIR=$(out)" "PREFIX=" ];
}
