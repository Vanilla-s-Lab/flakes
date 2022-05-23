# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  oh-my-posh = {
    pname = "oh-my-posh";
    version = "v7.90.2";
    src = fetchFromGitHub ({
      owner = "JanDeDobbeleer";
      repo = "oh-my-posh";
      rev = "v7.90.2";
      fetchSubmodules = false;
      sha256 = "sha256-vjGDNrjAPlhUfeCRIrD4TR1xAFKOTPaWvp1HG5HpLvU=";
    });
  };
  rose-pine = {
    pname = "rose-pine";
    version = "7c3625f3d0f34359ba114e09b1ba3f3c1bed399a";
    src = fetchgit {
      url = "https://github.com/rose-pine/alacritty";
      rev = "7c3625f3d0f34359ba114e09b1ba3f3c1bed399a";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-fjzKxSXGv0yLmT+VAonRCxlqQldxrHWUQgsOugobFoU=";
    };
  };
}