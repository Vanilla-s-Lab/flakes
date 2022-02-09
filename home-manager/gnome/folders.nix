{ ... }:
{
  dconf.settings = {
    "org/gnome/desktop/app-folders".folder-children = [
      "d3165349-919a-496a-acbb-7a59027f0f54" # Fcitx 5
      "4e0291de-0741-434f-94ef-75ff8dc5ef2c" # WeChat
      "466c96ac-0106-4985-a59c-404a9d69a44e" # WPS Office
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
      name = "WeChat";
      apps = [
        "wine-wechat.desktop"
        "wine-wechat-cfg.desktop"
        "wine-wechat-dir.desktop"
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
  };
}
