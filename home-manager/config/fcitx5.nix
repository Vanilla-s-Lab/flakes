{ lib, ... }:
{
  home.file.".config/fcitx5/config".text = "";
  home.file.".config/fcitx5/profile".text = lib.generators.toINI { } {
    GroupOrder = { "0" = "Default"; };
    "Groups/0" = { "Default Layout" = "us"; DefaultIM = "pinyin"; Name = "Default"; };
    "Groups/0/Items/0" = { Layout = ""; Name = "keyboard-us"; };
    "Groups/0/Items/1" = { Layout = ""; Name = "pinyin"; };
  };

  home.file.".config/fcitx5/conf/pinyin.conf".text = ''
    CloudPinyinEnabled=True
    PageSize=10
  '';
}
