{ pkgs, lib, ... }: with lib;
let buildFeeds = mapAttrsToList (tag: repoList: (forEach repoList (repo:
  { name = "https://github.com/${repo}/tags.atom"; value = { tags = [ tag ]; }; }
))); in
{
  home.packages = [
    pkgs.gnome-feeds
  ];

  home.file.".config/org.gabmus.gfeeds.json".text = builtins.toJSON {
    # nix-build maintainers/scripts/build.nix --argstr maintainer vanilla 
    feeds = builtins.listToAttrs (flatten (buildFeeds {
      "NixOS" = [
        "daniruiz/flat-remix-gnome"
        "thezbyg/gpick"
        "vinceliuice/Layan-gtk-theme"
        "lhvy/pipes-rs"
        "laughedelic/pisces"
        "mariadb-corporation/mariadb-connector-python"
      ];
    }));

    tags = [ "NixOS" ];

    # General - Refresh articles on startup - ON
    refresh_on_startup = true;
    # Advanced - Maximum refresh threads - 8
    max_refresh_threads = 8;
  };
}
