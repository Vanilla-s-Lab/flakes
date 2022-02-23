{ pkgs, lib, config, ... }: with lib;
let buildFeeds = mapAttrsToList (tag: repoList: (forEach repoList (repo:
  { name = "https://github.com/${repo}.atom"; value = { tags = [ tag ]; }; }
))); in
{
  home.packages = [
    pkgs.gnome-feeds
  ];

  home.file.".config/org.gabmus.gfeeds.json".text = builtins.toJSON {
    # nix-build maintainers/scripts/build.nix --argstr maintainer vanilla 
    feeds = builtins.listToAttrs (flatten (buildFeeds {
      "NixOS" = [
        "daniruiz/flat-remix-gnome/releases"
        "thezbyg/gpick/tags"
        "vinceliuice/Layan-gtk-theme/releases"
        "lhvy/pipes-rs/releases"
        "laughedelic/pisces/releases"
        "mariadb-corporation/mariadb-connector-python/tags"
      ];

      "Magisk" = [
        "kdrag0n/android12-extensions/releases"
        "XEonAX/ANXVerse/tags"
        "Magisk-Modules-Repo/energizedprotection/commits"
        "simonsmh/notocjk/releases"
        "gloeyisk/universal-gms-doze/releases"
        "yc9559/uperf/releases"
        "LSPosed/LSPosed/releases"
      ];

      "LSPosed" = [
        "LSPosed/CorePatch/releases"
        "KieronQuinn/DarQ/releases"
        "Xposed-Modules-Repo/io.github.tehcneko.applinkverify/releases"
        "xloger/ExLink/commits"
        "Xposed-Modules-Repo/org.hello.coolapk/releases"
        "Dr-TSNG/Hide-My-Applist/releases"
        "shatyuka/Killergram/releases"
        "KitsunePie/QQCleaner/releases"
        "Xposed-Modules-Repo/com.fkzhang.qqxposed/releases"
        "KieronQuinn/SIMNumberSetter/releases"
        "Tornaco/Thanox/releases"
        "fankes/TSBattery/releases"
        "Dr-TSNG/TwiFucker/releases"
        "Xposed-Modules-Repo/com.fkzhang.wechatxposed/releases"
        "yujincheng08/BiliRoaming/releases"
        "shatyuka/Zhiliao/releases"
      ];
    }));

    tags = [ "NixOS" ];

    # General - Refresh articles on startup - ON
    refresh_on_startup = true;
    # Advanced - Maximum refresh threads - 8
    max_refresh_threads = 8;
  };

  home.file.".cache/org.gabmus.gfeeds".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/org.gabmus.gfeeds";
}
