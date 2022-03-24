{ stdenv, fetchgit, kernel, ... }:
stdenv.mkDerivation rec {
  name = "dev_rickroll-${version}-${kernel.version}";
  version = "ed0760b";

  src = fetchgit {
    url = "https://github.com/lajp/dev_rickroll";
    rev = "${version}66848dab53483dd5645650fdae23bfccb";
    sha256 = "sha256-uL4Xak9y8kgOEeY26MWmnJlapOz3QhMNc4Cdx7rUNb8=";
  };

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];
}
