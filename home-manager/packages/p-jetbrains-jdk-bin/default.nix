{ callPackage, fetchurl, ... }:
let sources = callPackage ./sources.nix { inherit fetchurl; };
in sources.sources.p-jetbrains-jdk-bin
