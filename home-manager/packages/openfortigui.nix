{ stdenv, fetchgit, cmake, libsForQt5, makeDesktopItem, ... }:
let shortHash = "31eff99"; in
stdenv.mkDerivation rec {
  pname = "openfortigui";
  version = "v0.9.8";

  src = fetchgit {
    url = "https://github.com/theinvisible/${pname}";
    rev = "${shortHash}" + "39a0d1ba1dbf1cee52f10dd61038cadee";
    hash = "sha256-jKdHkrYo9FcRtX8j7HstutPGQf82P/wV1fo+KxHGXyo=";
  };

  nativeBuildInputs = with libsForQt5; [ qmake wrapQtAppsHook ];
  buildInputs = [ libsForQt5.qtkeychain ];

  installPhase = ''
    cd /build/${pname}-${shortHash}/${pname}
    mkdir -p $out/bin && cp ${pname} $_

    cd /build/${pname}-${shortHash}/${pname}/app-entry
    mkdir -p $out/share/pixmaps && cp ${pname}.png $_

    cp -r ${desktop}/share $out
  '';

  # https://github.com/theinvisible/openfortigui/blob/master/openfortigui/app-entry/openfortigui.desktop
  desktop = makeDesktopItem rec {
    name = "${pname}";

    type = "Application";
    desktopName = "${pname}";
    comment = "GUI for openfortivpn";

    icon = "${pname}";
    exec = "${pname}";

    terminal = false;
    categories = [ "Network" "${type}" ];
  };
}
