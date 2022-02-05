{ ... }:
{
  dconf.settings = {
    "org/gnome/desktop/app-folders".folder-children =
      [ "d3165349-919a-496a-acbb-7a59027f0f54" "4e0291de-0741-434f-94ef-75ff8dc5ef2c" ];

    "org/gnome/desktop/app-folders/folders/d3165349-919a-496a-acbb-7a59027f0f54" = {
      apps = [
        "org.fcitx.Fcitx5.desktop"
        "fcitx5-configtool.desktop"
        "org.fcitx.fcitx5-migrator.desktop"
      ];

      name = "Fcitx 5";
    };

    "org/gnome/desktop/app-folders/folders/4e0291de-0741-434f-94ef-75ff8dc5ef2c" = {
      apps = [
        "wine-wechat.desktop"
        "wine-wechat-cfg.desktop"
        "wine-wechat-dir.desktop"
      ];

      name = "WeChat";
    };
  };
}
