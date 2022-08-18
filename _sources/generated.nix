# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  "\"github/copilot.vim\"" = {
    pname = "\"github/copilot.vim\"";
    version = "554460008f18cbffecb9f1e5de58fec8410dc16f";
    src = fetchgit {
      url = "https://github.com/github/copilot.vim";
      rev = "554460008f18cbffecb9f1e5de58fec8410dc16f";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-kkycy2AWyV8SaADBFAH4tXOu9GFdubRbMti1goCAkKU=";
    };
  };
  "\"rose-pine/kitty\"" = {
    pname = "\"rose-pine/kitty\"";
    version = "f9a0cbeec44f61d83331dec5a07441b8067bee11";
    src = fetchgit {
      url = "https://github.com/rose-pine/kitty";
      rev = "f9a0cbeec44f61d83331dec5a07441b8067bee11";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-fZimTxjglj6bK0Y6mPuFlrpMJddRJC2fFW1eebe8dy0=";
    };
  };
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "v102";
    src = fetchFromGitHub ({
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v102";
      fetchSubmodules = false;
      sha256 = "sha256-LwHDZV688YVkddgWVUIk07FUeT0Z+E+mETWmOZ7U73k=";
    });
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
  nautilus-git = {
    pname = "nautilus-git";
    version = "5389549b4bcde91cf8d691e61a4a28d3428ddb3c";
    src = fetchgit {
      url = "https://github.com/bilelmoussaoui/nautilus-git";
      rev = "5389549b4bcde91cf8d691e61a4a28d3428ddb3c";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-p6Txm8EsFjEULVLrsMqPKrDpZPny+4+k6QnMhG84oDw=";
    };
  };
  nautilus-terminal = {
    pname = "nautilus-terminal";
    version = "v4.0.6";
    src = fetchFromGitHub ({
      owner = "flozz";
      repo = "nautilus-terminal";
      rev = "v4.0.6";
      fetchSubmodules = false;
      sha256 = "sha256-jVbvJZ0/Tuor6d4t9Hv22h5MLf2bJasguNiFkVBLoqw=";
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
