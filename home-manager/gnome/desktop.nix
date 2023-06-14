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
      "466c96ac-0106-4985-a59c-404a9d69a44e" # WPS Office
      "f31c95a8-8ed5-43d0-b849-c02b87cf6f2c" # Terminal
      "046ad3d2-1480-422d-89a4-f8bd19324788" # Autostart
      "22647c69-a025-4142-ace6-9ea9a0cbdca1" # IDEs
      "e644c5d3-83a7-463c-bbef-e0dbbea16076" # Virtualisation
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

    "org/gnome/desktop/app-folders/folders/466c96ac-0106-4985-a59c-404a9d69a44e" = {
      name = "WPS Office";
      apps = [
        "wps-office-prometheus.desktop"
        "wps-office-pdf.desktop"
        "wps-office-wpp.desktop"
        "wps-office-et.desktop"
        "wps-office-wps.desktop"
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

    "org/gnome/desktop/app-folders/folders/e644c5d3-83a7-463c-bbef-e0dbbea16076" = {
      name = "Virtualisation";
      apps = [
        "virtualbox.desktop"
        "playonlinux.desktop"
        "virt-manager.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/216c8193-f990-444b-8882-ea9d773441ef" = {
      name = "Internet";
      apps = [
        "chromium-browser.desktop"
        "firefox-devedition.desktop"
        "syncplay.desktop"
        "syncplay-server.desktop"
        "torbrowser.desktop"
        "org.wireshark.Wireshark.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/337d3799-cc4d-47f5-a6ce-5943775f331e" = {
      name = "Document";
      apps = [
        "org.gnome.Evince.desktop"
        "nixos-manual.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/0a52de09-b4d8-462c-bf97-517e8bc27973" = {
      name = "Games";
      apps = [
        "com.obsproject.Studio.desktop"
        "mpv.desktop"
        "Ryujinx.desktop"
        "samrewritten.desktop"
        "steam.desktop"
        "org.yuzu_emu.yuzu.desktop"
        "osu.desktop"
        "umpv.desktop"
      ];
    };
  };

  home.file.".config/VirtualBox".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/VirtualBox";

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

    pkgs.teamspeak_client
    pkgs.android-studio

    pkgs.apktool
    pkgs.dex2jar
    pkgs.jd-gui

    pkgs.remmina

    pkgs.gnome.gnome-disk-utility
    pkgs.nur.repos.xddxdd.qq
  ] ++ [ pkgs.yuzu-ea pkgs.ryujinx ];


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

  home.file.".gradle".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/gradle";

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
