{ pkgs, ... }:
{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Enable fcitx5 with chinese addons.
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [
    pkgs.fcitx5-chinese-addons
  ];
}
