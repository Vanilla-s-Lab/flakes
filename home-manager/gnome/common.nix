{ pkgs, config, lib, ... }:
# WeChat ID: My_Aim_Sucks
let wxid = "wxid_2tafg8vy4onr22"; in

let callPackage = pkgs.callPackage; in
let nautilus-admin = callPackage ../packages/nautilus-admin.nix { }; in
let nautilus-bluetooth = callPackage ../packages/nautilus-bluetooth.nix { }; in
let nautilus-terminal = callPackage ../packages/nautilus-terminal.nix { }; in
let nautilus-git = callPackage ../packages/nautilus-git.nix { }; in
let seahorse-nautilus = callPackage ../packages/seahorse-nautilus { }; in

let extensions = pkgs.runCommand "extensions" { } ''
  mkdir -p $out

  cp ${pkgs.gnome.nautilus-python}/lib/nautilus/extensions-3.0/*.la $out
  cp ${pkgs.gnome.nautilus-python}/lib/nautilus/extensions-3.0/*.so $out

  cp ${nautilus-bluetooth}/*.la $out
  cp ${nautilus-bluetooth}/*.so $out

  # cp ${seahorse-nautilus}/lib/nautilus/extensions-3.0/*.la $out
  cp ${seahorse-nautilus}/lib/nautilus/extensions-3.0/*.so $out
''; in
{
  home.packages = [
    # https://github.com/Stunkymonkey/nixos/blob/master/nixos/modules/nautilus.nix
    (pkgs.gnome.nautilus.overrideAttrs (old: {
      preFixup = old.preFixup + ''
        gappsWrapperArgs+=(
          --prefix NAUTILUS_EXTENSION_DIR : "${extensions}"

          # https://github.com/GNOME/nautilus-python
          --prefix XDG_DATA_DIRS : "${nautilus-admin}/usr/share"
          --prefix XDG_DATA_DIRS : "${nautilus-terminal}/.local/share"
          --prefix XDG_DATA_DIRS : "${nautilus-git}/share"

          --prefix GI_TYPELIB_PATH : "${pkgs.vte}/lib/girepository-1.0"

          # https://github.com/NixOS/nixpkgs/issues/64970
          # https://github.com/NixOS/nixpkgs/pull/64627/commits
          --prefix GI_TYPELIB_PATH : "${pkgs.gtksourceview}/lib/girepository-1.0"

          # Otherwise, `nautilus` will fallback to use system Python.
          --prefix PATH : "${pkgs.python3.withPackages (p: [ nautilus-terminal ])}/bin"
          --prefix PATH : "${seahorse-nautilus}/bin" # `seahorse-tool` is a helper.
        )
      '';
    }))

    pkgs.gnome.sushi
    pkgs.gnome.gedit

    pkgs.epiphany
    pkgs.gnome.geary
    pkgs.gnome.gnome-calendar
    pkgs.lollypop
    pkgs.gnome.totem
    pkgs.gnome.eog

    pkgs.evince
    pkgs.thunderbird
  ];

  # https://github.com/flozz/nautilus-terminal/tree/v4.0.4#configuring=
  # @see `nautilus_terminal/nautilus_terminal.py`, Soft != clear.
  dconf.settings."org/flozz/nautilus-terminal".auto-clean = "Soft";

  # https://github.com/rose-pine/alacritty/blob/main/dist/rose-pine-dawn.yml
  dconf.settings."org/flozz/nautilus-terminal".background-color = "#faf4ed";
  dconf.settings."org/flozz/nautilus-terminal".foreground-color = "#575279";

  # https://github.com/nix-community/home-manager/blob/master/modules/lib/gvariant.nix # 9, ⑨!
  dconf.settings."org/flozz/nautilus-terminal".min-terminal-height = (lib.hm.gvariant.mkUint32 (5 + (2 * 2)));
  dconf.settings."org/flozz/nautilus-terminal".terminal-bottom = true;

  home.file.".thunderbird".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/thunderbird";

  home.file.".cache/thunderbird".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/thunderbird";

  dconf.settings = {
    # Nautilus - Scroll Down Twice.
    "org/gnome/nautilus/icon-view".default-zoom-level = "small";

    "org/gnome/nautilus/window-state" = {
      # Nautilus - Let sidebar contains '[ip]:...' of ftp.
      sidebar-width = 211;

      # Type: (ii), Default value: (890, 550).
      initial-size = (lib.hm.gvariant.mkTuple
        [ 890 (550 + (117 - 69)) ]);
    };

    # Text Editor - Preferences - Font & Colors - Color Scheme - Flat-Remix
    "org/gnome/gedit/preferences/editor".scheme = "Flat-Remix";
    # Text Editor - Preferences - Plugins - Enable All.
    "org/gnome/gedit/plugins".active-plugins = [
      "time"
      "spell"
      "sort"
      "snippets"
      "quickopen"
      "quickhighlight"
      "pythonconsole"
      "modelines"
      "filebrowser"
      "externaltools"
      "docinfo"
    ];
  };

  # Caution: Whitespace should replaced by '%20'.
  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/vanilla/Works Works
    file:///home/vanilla/Projects Projects
    file:///home/vanilla/.local/lib/wine-wechat/default/drive_c/WeChat%20Files/${wxid}/FileStorage/File wechat_file
  '';

  # https://github.com/NixOS/nixpkgs/issues/163080
  home.file.".face".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Pictures/avatar.png";
}
