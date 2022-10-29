{ buildFHSUserEnv, fetchurl, runCommand, unzip, ... }:

let pname = "github-copilot-intellij"; in
let version = "1.1.35.2063"; in

let src = fetchurl {
  url = "https://plugins.jetbrains.com/files/17718/243369/${pname}-${version}.zip";
  hash = "sha256-kznE/3GwE1xHF95Qlr1Ukea4zwtCK2CCrhoDaOjHLuY=";
}; in

let name = "copilot-agent-linux"; in
let binary = runCommand "unzip-src" { } ''
  mkdir -p $out/bin

  # https://unix.stackexchange.com/questions/14120
  ${unzip}/bin/unzip -p ${src} ${pname}/copilot-agent/bin/${name} > $_/${name}

  chmod +x $out/bin/${name}
''; in

# https://github.com/community/community/discussions/17898
buildFHSUserEnv {
  inherit name;
  runScript = "${binary}/bin/${name}";

  passthru = {
    inherit pname;
  };
}
