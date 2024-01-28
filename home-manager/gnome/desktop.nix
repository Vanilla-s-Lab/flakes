{ pkgs, config, lib, generated, ... }:
{
  dconf.settings = {
    "org/gnome/shell".favorite-apps = [
      "org.gnome.Epiphany.desktop"
      "org.gnome.Geary.desktop"
      "org.gnome.Calendar.desktop"
      "org.gnome.Lollypop.desktop"
      "org.gnome.Totem.desktop"
      "org.gnome.eog.desktop"
    ];

    "org/gnome/desktop/app-folders".folder-children = [
      "d3165349-919a-496a-acbb-7a59027f0f54" # Fcitx 5
      "4e0291de-0741-434f-94ef-75ff8dc5ef2c" # Work
      "f31c95a8-8ed5-43d0-b849-c02b87cf6f2c" # Terminal
      "046ad3d2-1480-422d-89a4-f8bd19324788" # Autostart
      "22647c69-a025-4142-ace6-9ea9a0cbdca1" # IDEs
      "216c8193-f990-444b-8882-ea9d773441ef" # Internet
      "337d3799-cc4d-47f5-a6ce-5943775f331e" # Document
      "0a52de09-b4d8-462c-bf97-517e8bc27973" # Games
    ];

    "org/gnome/desktop/app-folders/folders/d3165349-919a-496a-acbb-7a59027f0f54" = {
      name = "Fcitx 5";
      apps = [
        "org.fcitx.Fcitx5.desktop"
        "fcitx5-configtool.desktop"
        "org.fcitx.fcitx5-migrator.desktop"
        "kbd-layout-viewer5.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/4e0291de-0741-434f-94ef-75ff8dc5ef2c" = {
      name = "Work";
      apps = [
        "org.gnome.DiskUtility.desktop"
        "org.remmina.Remmina.desktop"
        "qq.desktop"
        "wine-wechat.desktop"
        "wine-wechat-cfg.desktop"
        "wine-wechat-dir.desktop"
        "wemeetapp.desktop"
        "wemeetapp-force-x11.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/f31c95a8-8ed5-43d0-b849-c02b87cf6f2c" = {
      name = "Terminal";
      apps = [
        "Alacritty.desktop"
        "fish.desktop"
        "kitty.desktop"
        "xterm.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/046ad3d2-1480-422d-89a4-f8bd19324788" = {
      name = "Autostart";
      apps = [
        "albert.desktop"
        "clash-for-windows.desktop"
        "kotatogramdesktop.desktop"
        "qv2ray.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/22647c69-a025-4142-ace6-9ea9a0cbdca1" = {
      name = "IDEs";
      apps = [
        "android-studio.desktop"
        "clion.desktop"
        "codium.desktop"
        "datagrip.desktop"
        "gateway.desktop"
        "goland.desktop"
        "idea-ultimate.desktop"
        "jd-gui.desktop"
        "nvim.desktop"
        "pycharm-professional.desktop"
        "rider.desktop"
        "ruby-mine.desktop"
        "webstorm.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/216c8193-f990-444b-8882-ea9d773441ef" = {
      name = "Internet";
      apps = [
        "chromium-browser.desktop"
        "firefox-developer-edition.desktop"
        "mpv.desktop"
        "syncplay.desktop"
        "syncplay-server.desktop"
        "torbrowser.desktop"
        "org.wireshark.Wireshark.desktop"
        "umpv.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/337d3799-cc4d-47f5-a6ce-5943775f331e" = {
      name = "Document";
      apps = [
        "org.gnome.Evince.desktop"
        "nixos-manual.desktop"
        "xdvi.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/0a52de09-b4d8-462c-bf97-517e8bc27973" = {
      name = "Games";
      apps = [
        "com.obsproject.Studio.desktop"
        "Ryujinx.desktop"
        "samrewritten.desktop"
        "steam.desktop"
        "OpenTabletDriver.desktop"
        "org.yuzu_emu.yuzu.desktop"
        "osu.desktop"
      ];
    };
  };

  home.file.".cache/Google".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/Google";

  home.file.".config/Google".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/Google";

  home.file.".java/.userPrefs/google".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/java/dot/userPrefs/google";

  home.file.".local/share/Google".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/Google";

  home.file.".local/share/TeamSpeak 3".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/TeamSpeak 3";

  home.packages = [
    pkgs.osu-lazer
    pkgs.nur.repos.xeals.samrewritten

    pkgs.syncplay
    pkgs.mpv

    pkgs.android-studio

    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui

    pkgs.remmina

    pkgs.gnome.gnome-disk-utility
    pkgs.nur.repos.xddxdd.qq
    # pkgs.nur.repos.xddxdd.baidunetdisk
  ] ++ [ pkgs.yuzu-ea pkgs.ryujinx ];

  # https://github.com/bloc97/Anime4K/blob/master/md/GLSL_Instructions_Linux.md
  home.file.".config/mpv/shaders".source = config.lib.file.mkOutOfStoreSymlink "/persistent/Templates/Anime4K_v4.0/";

  home.file.".config/mpv/input.conf".source = pkgs.fetchurl {
    # url = "https://raw.githubusercontent.com/bloc97/Anime4K/master/md/Template/GLSL_Mac_Linux_Low-end/input.conf";
    # hash = "sha256-1m36i1vMTL0kAHtGFgqZzkqB8G0IRt/YnU+PwuqF/70=";

    url = "https://raw.githubusercontent.com/bloc97/Anime4K/master/md/Template/GLSL_Mac_Linux_High-end/input.conf";
    hash = "sha256-ichZCEAKO6LIJhHlRl0zskofyoe00xzNqEOaICc3w74=";
  };

  home.file.".config/mpv/mpv.conf".source = pkgs.fetchurl {
    # url = "https://raw.githubusercontent.com/bloc97/Anime4K/master/md/Template/GLSL_Mac_Linux_Low-end/mpv.conf";
    # hash = "sha256-Q8nXI2V7q3wjVbh0YnWshs9kWuI68lnRSTaV4RW31oI=";

    url = "https://raw.githubusercontent.com/bloc97/Anime4K/master/md/Template/GLSL_Mac_Linux_High-end/mpv.conf";
    hash = "sha256-W+pZ5dx2u/KicxErifXjeYHC6ZUWbhYwiMdCEiQ98bc=";
  };

  home.file.".config/QQ".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/QQ";

  home.file.".cache/yuzu".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/yuzu";

  home.file.".config/yuzu".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/yuzu";

  home.file.".local/share/yuzu".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/yuzu";

  home.file.".config/Ryujinx/".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/Ryujinx";

  home.file."Android".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Android";

  home.file.".cache/remmina".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/remmina";

  home.file.".config/remmina".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/remmina";

  home.file.".local/share/remmina".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/remmina";
}
