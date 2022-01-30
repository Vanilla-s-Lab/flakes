{ lib, pkgs, ... }:
{
  programs.gpg.enable = true;
  programs.gpg.mutableKeys = false;
  programs.gpg.mutableTrust = false;

  programs.gpg.publicKeys = [{
    text = lib.readFile (pkgs.fetchurl rec {
      name = "0x3750028ed04fa42e";
      url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=${name}";
      hash = "sha256-l1KtfiS4p2SQYn/NN4BUXrzdtjgdIvT6G53LMxxlg0g=";
    });

    trust = "ultimate";
  }];
}
