{ lib, pkgs, ... }:
{
  programs.gpg.enable = true;
  programs.gpg.mutableKeys = false;
  programs.gpg.mutableTrust = false;

  programs.gpg.publicKeys = [{
    text = lib.readFile (pkgs.fetchurl rec {
      name = "0x3750028ed04fa42e";
      url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=${name}";
      hash = "sha256-HVIkOCn5aYmMEU8ryr68nyi+DLQhjr5/q4ZD0Hbqq5s=";
    });

    trust = "ultimate";
  }];
}
