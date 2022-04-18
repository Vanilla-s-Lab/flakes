{ callPackage, fetchurl, jetbrains, lib, pkgs, ... }:
let jbJdkVersion = jetbrains.jdk.version; in
let splitedList = (lib.strings.splitString "-" jbJdkVersion); in

let left = builtins.elemAt splitedList 0; in
let right = builtins.elemAt splitedList 1; in

# jbr_jcef-11_0_13-linux-x64-b1751.25.tar.gz
let sources = (callPackage ./sources.nix { inherit fetchurl left right; }); in
callPackage (import ./jdk.nix { self = pkgs; inherit (sources) sources; }) { }
