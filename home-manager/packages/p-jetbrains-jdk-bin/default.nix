{ callPackage, fetchurl, jetbrains, lib, ... }:
let jbJdkVersion = jetbrains.jdk.version; in
let splitedList = (lib.strings.splitString "-" jbJdkVersion); in

let left = builtins.elemAt splitedList 0; in
let right = builtins.elemAt splitedList 1; in

# jbr_jcef-11_0_13-linux-x64-b1751.25.tar.gz
(callPackage ./sources.nix { inherit fetchurl left right; }).sources.p-jetbrains-jdk-bin
