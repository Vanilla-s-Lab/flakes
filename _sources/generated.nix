# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  "\"GitHub.copilot\"" = {
    pname = "\"GitHub.copilot\"";
    version = "1.28.6134";
    src = fetchurl {
      url = "https://GitHub.gallery.vsassets.io/_apis/public/gallery/publisher/GitHub/extension/copilot/1.28.6134/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "copilot-1.28.6134.zip";
      sha256 = "sha256-o/vh80eTAquu82+nm1wDn/ZAaJwo6S39bNZVgjpuFxA=";
    };
  };
  "\"GitHub.copilot-labs\"" = {
    pname = "\"GitHub.copilot-labs\"";
    version = "0.1.176";
    src = fetchurl {
      url = "https://GitHub.gallery.vsassets.io/_apis/public/gallery/publisher/GitHub/extension/copilot-labs/0.1.176/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "copilot-labs-0.1.176.zip";
      sha256 = "sha256-nMGXgfeMOi6GoJZemQMNz9hB0cy4JSXKkmv3Fw98BOI=";
    };
  };
  "\"PKief.material-icon-theme\"" = {
    pname = "\"PKief.material-icon-theme\"";
    version = "4.18.1";
    src = fetchurl {
      url = "https://PKief.gallery.vsassets.io/_apis/public/gallery/publisher/PKief/extension/material-icon-theme/4.18.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-4.18.1.zip";
      sha256 = "sha256-g+741XXYjL0RnrpUquHckK6sf61BpHpAd8S3QiIB5dY=";
    };
  };
  "\"unthrottled.doki-theme\"" = {
    pname = "\"unthrottled.doki-theme\"";
    version = "78.1.5";
    src = fetchurl {
      url = "https://unthrottled.gallery.vsassets.io/_apis/public/gallery/publisher/unthrottled/extension/doki-theme/78.1.5/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "doki-theme-78.1.5.zip";
      sha256 = "sha256-u1/20wvQC1j1UZlfCs29vDbFDGL7TGL4hXwj3knuf1U=";
    };
  };
  Boxfish = {
    pname = "Boxfish";
    version = "385c04e685ac6a5130f3f12aaca13642ee0dd3ba";
    src = fetchgit {
      url = "https://github.com/MidAutumnMoon/Boxfish";
      rev = "385c04e685ac6a5130f3f12aaca13642ee0dd3ba";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-ohBwPRuAHLVwESvtHyRb/VobwtHg7S7+Pi6fk2SD2EU=";
    };
  };
  nautilus-admin = {
    pname = "nautilus-admin";
    version = "v1.1.9";
    src = fetchFromGitHub ({
      owner = "brunonova";
      repo = "nautilus-admin";
      rev = "v1.1.9";
      fetchSubmodules = false;
      sha256 = "sha256-aJhjV/sN9RPLttYoKADr9b9VqRW7zXKAHFDdz3Jp8n0=";
    });
  };
  nautilus-bluetooth = {
    pname = "nautilus-bluetooth";
    version = "1.0.5";
    src = fetchFromGitHub ({
      owner = "madmurphy";
      repo = "nautilus-bluetooth";
      rev = "1.0.5";
      fetchSubmodules = false;
      sha256 = "sha256-I+UH2tO6WO72UptM8sMHJfvqX0492w2yW2mrzv5U/WU=";
    });
  };
  nushell = {
    pname = "nushell";
    version = "0.64.0";
    src = fetchFromGitHub ({
      owner = "nushell";
      repo = "nushell";
      rev = "0.64.0";
      fetchSubmodules = false;
      sha256 = "sha256-mDKoZVen3g8GujWF8WILEqdlHFDx2BxGyBJJFmK9Mdw=";
    });
  };
  oh-my-posh = {
    pname = "oh-my-posh";
    version = "v8.5.0";
    src = fetchFromGitHub ({
      owner = "JanDeDobbeleer";
      repo = "oh-my-posh";
      rev = "v8.5.0";
      fetchSubmodules = false;
      sha256 = "sha256-s00k+GvV1UNYEbXlUIPF5QcgVcyPjRlO02xiZW+r/pM=";
    });
  };
  plugin-kubectl = {
    pname = "plugin-kubectl";
    version = "dd8012f3ebfb3ceec4c693f3cc12e4c1397ac9c8";
    src = fetchgit {
      url = "https://github.com/blackjid/plugin-kubectl";
      rev = "dd8012f3ebfb3ceec4c693f3cc12e4c1397ac9c8";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-wLeWzPJz5AmcSprq5lIcR+3onjL7uIFCM2zj71pL2rs=";
    };
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
