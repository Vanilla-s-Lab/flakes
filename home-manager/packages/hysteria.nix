{ stdenv, fetchurl, ... }:
stdenv.mkDerivation rec {
  pname = "hysteria";
  version = "0.9.7";

  src = fetchurl {
    url = "https://github.com/HyNetwork/hysteria" +
      "/releases/download/v${version}/${pname}-linux-amd64";
    hash = "sha256-5TIurHhXsTxl77e5+cZLH9OAVwgTdFL9PmI+Xl9ODlw=";
  };

  unpackPhase = "echo";
  installPhase = ''
    mkdir -p $out/bin && cp ${src} $out/bin/hysteria
    chmod +x $out/bin/hysteria
  '';
}
