{ callPackage, stdenv, kernel, fetchFromGitHub, bc, lib, ... }:
let generated = callPackage ../../../_sources/generated.nix { }; in
stdenv.mkDerivation rec {
  pname = generated.rtl88x2bu.pname;
  version = generated.rtl88x2bu.version;

  src = generated.rtl88x2bu.src;

  # https://github.com/cilynx/rtl88x2bu/blob/5.8.7.1_35809.20191129_COEX20191120-7777/Makefile#L1355=
  patches = [ ./nix_install.patch ./no-depmod.patch ]; # [1] related to [0]!
  postPatch = "substituteInPlace Makefile --replace 'NIX_INSTALL' $out";

  # https://nixos.wiki/wiki/Linux_kernel#Packaging_out-of-tree_kernel_modules
  nativeBuildInputs = kernel.moduleBuildDependencies ++ [ bc ];

  makeFlags = [
    "KVER=${kernel.modDirVersion}"
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ] ++ lib.singleton (" " + "-j 6" + " ");

  # /lib/modules/5.15.16-lqx2/kernel/drivers/net/wireless/
  MODDESTDIR = "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/";
  installPhase = "mkdir -p ${MODDESTDIR} && make install";
}
