{ stdenv, fetchgit, libmicrohttpd, ... }:
stdenv.mkDerivation rec {
  pname = "nodogsplash";
  version = "5.0.0";

  src = fetchgit {
    url = "https://github.com/${pname}/${pname}";
    rev = "v${version}";
    hash = "sha256-hnr0KiI4zi8SyoUdy8neLmNUBJoSyRHNPpwRkOnuqw8=";
  };

  buildInputs = [ libmicrohttpd ];

  makeFlags = [ "DESTDIR=$(out)" ];
  patchPhase = ''
    substituteInPlace ./Makefile \
      --replace '$(DESTDIR)/usr' "$out"
  '';
}
