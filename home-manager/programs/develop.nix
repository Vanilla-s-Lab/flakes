{ pkgs, config, ... }:
{
  home.packages = [
    (pkgs.python3.withPackages (p: with p; [ pygobject3 ]
      ++ [ pip setuptools ] ++ [ mariadb XlsxWriter pandas ]))

    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.idea-ultimate
  ];

  home.file.".cache/JetBrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/JetBrains";

  home.file.".config/JetBrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/JetBrains";

  home.file.".local/share/JetBrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/JetBrains";

  home.file.".java/.userPrefs/jetbrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/java/dot/userPrefs/jetbrains";
}
