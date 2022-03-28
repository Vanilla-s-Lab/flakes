{ stdenv, fetchurl, dpkg, autoPatchelfHook, glib, dbus-glib, gtk2-x11, xorg, alsa-lib, ... }:
stdenv.mkDerivation rec {
  pname = "EasyConnect";
  version = "767";

  # https://aur.archlinux.org/packages/easyconnect
  src = fetchurl {
    url = "http://download.sangfor.com.cn/download" +
      "/product/sslvpn/pkg/linux_${version}/${pname}_x64_7_6_7_3.deb";
    hash = "sha256-qo2wr0NgDOvKilBP+cO07bUO/8ejTStcI5xZ8tegBAo=";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook ];
  unpackPhase = "dpkg-deb -x ${src} .";

  installPhase = ''
    mkdir -p $out && cp -r * $out
    chmod +x $out/usr/share/sangfor/EasyConnect/EasyConnect
  '';

  buildInputs = [ glib dbus-glib gtk2-x11 xorg.libXtst alsa-lib xorg.libXdamage ];
  meta = { broken = true; };
}
