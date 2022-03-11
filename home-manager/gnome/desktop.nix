{ ... }:
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
      "046ad3d2-1480-422d-89a4-f8bd19324788" # Autostart
      "22647c69-a025-4142-ace6-9ea9a0cbdca1" # IDEs
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
        "wine-wechat.desktop"
        "wine-wechat-cfg.desktop"
        "wine-wechat-dir.desktop"
        "wemeetapp.desktop"
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

    "org/gnome/desktop/app-folders/folders/046ad3d2-1480-422d-89a4-f8bd19324788" = {
      name = "Autostart";
      apps = [ "albert.desktop" "kotatogramdesktop.desktop" "qv2ray.desktop" ];
    };

    "org/gnome/desktop/app-folders/folders/22647c69-a025-4142-ace6-9ea9a0cbdca1" = {
      name = "IDEs";
      apps = [
        "android-studio-stable-2020.3.1.25.desktop"
        "clion.desktop"
        "datagrip.desktop"
        "idea-ultimate.desktop"
        "pycharm-professional.desktop"
        "rider.desktop"
      ];
    };
  };
}
