{ self, sources, ... }:
let inherit (self) lib;
in { stdenv, zlib, xorg, freetype, alsa-lib, atk, at-spi2-atk, at-spi2-core, cups, dbus
, expat, fontconfig, glib, libdrm, libxkbcommon, mesa, nspr, nss, libglvnd, libudev
, setJavaClassPath }:
let
  result = stdenv.mkDerivation {
    pname = "p-jetbrains-jdk-bin";
    inherit (sources.p-jetbrains-jdk-bin) version src;

    dontStrip = true; # See: https://github.com/NixOS/patchelf/issues/10
    postFixup = ''
      rpath="$out/lib/jli:$out/lib/server:$out/lib:${
        lib.makeLibraryPath [
          zlib
          xorg.libX11
          xorg.libXext
          xorg.libXtst
          xorg.libXi
          xorg.libXrender
          freetype
          alsa-lib

          atk
          at-spi2-atk
          at-spi2-core
          cups
          dbus
          expat
          fontconfig
          glib
          libdrm
          libxkbcommon
          mesa
          nspr
          nss
          stdenv.cc.cc.lib
          xorg.libxcb
          xorg.libXcomposite
          xorg.libXcursor
          xorg.libXdamage
          xorg.libXfixes
          xorg.libXrandr
          xorg.libxshmfence
          xorg.libXxf86vm
          # runtime?
          libglvnd
          libudev
          mesa.drivers
        ]
      }"

      for f in $(find $out -name "*.so") $(find $out -type f -perm -0100); do
        patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$f" || true
        patchelf --set-rpath   "$rpath"                                    "$f" || true
      done

      for f in $(find $out -name "*.so") $(find $out -type f -perm -0100); do
        if ldd "$f" | fgrep 'not found'; then echo "in file $f"; fi
      done
    '';

    installPhase = ''
      mv ../$sourceRoot $out

      mkdir -p $out/nix-support
      printWords ${setJavaClassPath} > $out/nix-support/propagated-build-inputs

      # Set JAVA_HOME automatically.
      cat <<EOF >> $out/nix-support/setup-hook
      if [ -z "\''${JAVA_HOME-}" ]; then export JAVA_HOME=$out; fi
      EOF
    '';

    passthru.jre = result;
    passthru.home = result;
    meta = with lib; { platforms = [ "x86_64-linux" ]; };
  };
in result
