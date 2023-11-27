# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  daniruiz_flat-remix-gnome = {
    pname = "daniruiz_flat-remix-gnome";
    version = "20231026";
    src = fetchFromGitHub {
      owner = "daniruiz";
      repo = "flat-remix-gnome";
      rev = "20231026";
      fetchSubmodules = false;
      sha256 = "sha256-sKQOq0GMslkzND2ayL5M6XIxJv8t0yj6XCP3poA6wRc=";
    };
  };
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "v120";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v120";
      fetchSubmodules = false;
      sha256 = "sha256-CBw2JMrQO5ymFVyR/Qtcn5iTp+Hp0sQe7v0DviH9zRY=";
    };
  };
  gnome-shell-extension-sensory-perception = {
    pname = "gnome-shell-extension-sensory-perception";
    version = "v18";
    src = fetchFromGitHub {
      owner = "HarlemSquirrel";
      repo = "gnome-shell-extension-sensory-perception";
      rev = "v18";
      fetchSubmodules = false;
      sha256 = "sha256-WyMOMPHsLP0CiHpuhafxT1vEKTgEqPRoQAEMA17pFtU=";
    };
  };
  longld_peda = {
    pname = "longld_peda";
    version = "v1.2";
    src = fetchFromGitHub {
      owner = "longld";
      repo = "peda";
      rev = "v1.2";
      fetchSubmodules = false;
      sha256 = "sha256-vtNJ9WHCUtZmIn/IXwwtKrZx1i/az+gMmW6fLd67QYQ=";
    };
  };
  oh-my-fish_plugin-bang-bang = {
    pname = "oh-my-fish_plugin-bang-bang";
    version = "ec991b80ba7d4dda7a962167b036efc5c2d79419";
    src = fetchgit {
      url = "https://github.com/oh-my-fish/plugin-bang-bang";
      rev = "ec991b80ba7d4dda7a962167b036efc5c2d79419";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-oPPCtFN2DPuM//c48SXb4TrFRjJtccg0YPXcAo0Lxq0=";
    };
    date = "2023-07-23";
  };
  rose-pine_kitty = {
    pname = "rose-pine_kitty";
    version = "788bf1bf1a688dff9bbacbd9e516d83ac7dbd216";
    src = fetchgit {
      url = "https://github.com/rose-pine/kitty";
      rev = "788bf1bf1a688dff9bbacbd9e516d83ac7dbd216";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-AcMVkliLGuabZVGkfQPLhfspkaTZxPG5GyuJdzA4uSg=";
    };
    date = "2023-09-01";
  };
  vinceliuice_Layan-gtk-theme = {
    pname = "vinceliuice_Layan-gtk-theme";
    version = "2023-05-23";
    src = fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Layan-gtk-theme";
      rev = "2023-05-23";
      fetchSubmodules = false;
      sha256 = "sha256-R8QxDMOXzDIfioAvvescLAu6NjJQ9zhf/niQTXZr+yA=";
    };
  };
}
