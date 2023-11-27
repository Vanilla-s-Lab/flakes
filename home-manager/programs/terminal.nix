{ lib, pkgs, config, generated, ... }:
let
  enable_feature = feature_list: builtins.listToAttrs
    (lib.lists.forEach feature_list # https://nixos.org/manual/nix/stable/expressions/builtins.html
      (x: { name = x; value = { disabled = false; }; }));
in

let joycond-cemuhook = "aa81791e2135cffc0686390003ef9e1915dfdd1fec3eaef15e27a1509e622403"; in
let vergedx.github.io = "17d04d213ad790e501d099ad8e68229f2f2c4bdcd92b3eeadd1a30a9e425166c"; in
let linode-nix = "8384794718e7179aa44ad91cd794e62ef2e99c9abd45b05bfd83b9c2e4a9fd7b"; in
let ariel-tf = "13d969eac201336200d564ca12ead9290ababc1a5c17a075bf8f9a9ce972ed47"; in
let SMSBoom = "a71b33f5974c3c82496b402a1e816c3dda0b0b9afd6b6c38835ec54d107a3c79"; in
{
  # https://github.com/alacritty/alacritty
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    import = lib.singleton
      (generated.rose-pine.src
        + "/dist/rose-pine-dawn.yml");

    font = {
      normal = { family = "Hack Nerd Font"; style = "Regular"; };
      bold = { family = "Hack Nerd Font"; style = "Bold"; };
      italic = { family = "Hack Nerd Font"; style = "Italic"; };
      size = 11.0;
    };

    # https://github.com/alacritty/alacritty/blob/master/alacritty.yml
    env = { TERM = "xterm-256color"; };

    shell = {
      program = "${pkgs.fish}/bin/fish";
      args = [ "--login" ];
    };
  };

  # https://github.com/fish-shell/fish-shell
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    any-nix-shell fish --info-right | source
    __git.destroy || true && __git.init
  '';

  # https://github.com/wawa19933/fish-systemd
  programs.fish.plugins = (lib.singleton rec {
    name = "fish-systemd";
    src = generated."wawa19933_${name}".src;
  }) ++ (lib.singleton rec {
    name = "plugin-bang-bang";
    src = pkgs.fetchgit {
      url = "https://github.com/oh-my-fish/${name}";
      rev = "f969c61" + "8301163273d0a03d002614d9a81952c1e";
      hash = "sha256-A8ydBX4LORk+nutjHurqNNWFmW6LIiBPQcxS3x4nbeQ=";
    };
  });

  programs.fish.functions = {
    "no_proxy".body = "set -e all_proxy ftp_proxy https_proxy http_proxy no_proxy rsync_proxy";
    "volume_67".body = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.67"; # GitLab - PipeWire - issues/976.
  };

  home.packages = [
    pkgs.screen
    pkgs.minicom
    pkgs.bat

    pkgs.nur.repos.linyinfeng.fishPlugins.git
    pkgs.fishPlugins.pisces
    pkgs.any-nix-shell

    # https://github.com/sharkdp/fd
    pkgs.fd
    # https://github.com/BurntSushi/ripgrep
    pkgs.ripgrep

    pkgs.powerline
  ];

  home.file.".config/nushell/env.nu".text = "";
  home.file.".config/nushell/config.nu".text = "";

  # https://starship.rs/
  programs.starship.enable = true;
  # https://starship.rs/config/
  programs.starship.settings = (enable_feature
    ([ "git_metrics" "kubernetes" "memory_usage" ]
      ++ [ "shell" "status" /* "sudo" */ "time" ]));

  # https://github.com/ogham/exa
  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  # https://github.com/rose-pine/fish
  home.file.".config/fish/functions/rose_pine.fish".source =
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/fish/main/rose_pine.fish";
      hash = "sha256-RSC7d0x+m2FWtNyN8WmmHNcTn2gL6ZS5tRsc3KJB8Hc=";
    };

  home.activation."rose_pine-dawn" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      ''${pkgs.fish}/bin/fish -c "rose_pine dawn" > /dev/null || true'';

  # https://github.com/nix-community/nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.file.".local/share/direnv/allow/${joycond-cemuhook}".text =
    "/persistent/Downloads/Temp/joycond-cemuhook/.envrc";
  home.file.".local/share/direnv/allow/${vergedx.github.io}".text =
    "/Repos/vergedx.github.io/.envrc";
  home.file.".local/share/direnv/allow/${linode-nix}".text =
    "/persistent/Projects/linode-nix/.envrc";
  home.file.".local/share/direnv/allow/${ariel-tf}".text =
    "/persistent/Works/ariel-tf/.envrc";
  home.file.".local/share/direnv/allow/${SMSBoom}".text =
    "/persistent/Downloads/Temp/SMSBoom";

  programs.kitty.enable = true;

  # https://github.com/kovidgoyal/kitty-themes/tree/master/themes
  programs.kitty.theme = "Rosé Pine Dawn";

  # https://sw.kovidgoyal.net/kitty/conf/
  programs.kitty.settings = {
    shell = "${pkgs.fish}/bin/fish";
  };

  programs.tmux.enable = true;
  programs.tmux.shell = "${pkgs.fish}/bin/fish";

  # https://powerline.readthedocs.io/en/latest/usage/other.html
  home.file.".tmux.conf".text = ''source "${pkgs.powerline}/share/tmux/powerline.conf"''
    # https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
    + "\n" + ''set -g default-terminal "tmux-256color"''
    + "\n" + ''set -ag terminal-overrides ",xterm-256color:RGB"''
    # https://superuser.com/questions/325110/how-to-turn-down-the-timeout-between-prefix-key-and-command-key-in-tmux
    + "\n" + ''set -g repeat-time 0'';

  # https://powerline.readthedocs.io/en/latest/configuration/reference.html#config-colors-colors
  # https://github.com/powerline/powerline/blob/develop/powerline/config_files/colorschemes/tmux/default.json
  home.file.".config/powerline/colorschemes/rose-pine.json".text = builtins.toJSON {
    name = "rose-pine";

    # https://github.com/powerline/powerline/blob/develop/powerline/config_files/themes/tmux/default.json
    # https://powerline.readthedocs.io/en/master/configuration/segments.html#segments
    groups = {
      # normal: a: rose + base; ( gray10 + black )
      hostname = { attrs = [ "bold" ]; bg = "rose"; fg = "base"; };

      # normal: b: overlay + rose; ( gray2 + gray [ 8 | 10 | 5 ] )
      date = { attrs = [ ]; bg = "overlay"; fg = "rose"; };
      time = { attrs = [ "bold" ]; bg = "overlay"; fg = "rose"; };
      "time:divider" = { attrs = [ ]; bg = "overlay"; fg = "rose"; };

      # normal: c: base + text; ( gray0 + gray8 )
      system_load = { attrs = [ ]; bg = "base"; fg = "text"; };
      uptime = { attrs = [ ]; bg = "base"; fg = "text"; };

      # background group, follows = "normal: c"
      background = { attrs = [ ]; bg = "base"; fg = "text"; };
      "background:divider" = { attrs = [ ]; bg = "base"; fg = "text"; };
    };
  };

  # All required args included.
  # `tmux -V`: tmux 3.2a; pkgs.powerline: Version: 2.8.2.
  home.file.".config/powerline/colorschemes/tmux/rose-pine.json".text = builtins.toJSON {
    groups = {
      # `normal: b & a` for session not active & active.
      session = { attrs = [ "bold" ]; bg = "overlay"; fg = "rose"; };
      "session:prefix" = { attrs = [ "bold" ]; bg = "rose"; fg = "base"; };

      # `normal c` for window list background.
      window = { attrs = [ ]; bg = "base"; fg = "text"; };

      # `normal: a` for selected window.
      "window:current" = { attrs = [ ]; bg = "rose"; fg = "base"; };
      window_name = { attrs = [ "bold" ]; bg = "rose"; fg = "base"; };

      # `normal: c` for unselected window.
      "window:divider" = { attrs = [ ]; bg = "base"; fg = "text"; };
      active_window_status = { attrs = [ ]; bg = "base"; fg = "text"; };
      window_status = { attrs = [ ]; bg = "base"; fg = "text"; };

      # `normal: c` for background window bell.
      bell_status = { attrs = [ ]; bg = "base"; fg = "text"; };

      # Deprecated in powerline 1.8 & 1.9...?
      activity_status = { attrs = [ ]; bg = "gray0"; fg = "yellow"; };
    };
  };

  # https://github.com/powerline/powerline/blob/develop/powerline/config_files/config.json
  home.file.".config/powerline/config.json".text = builtins.toJSON {
    ext = { tmux = { colorscheme = "rose-pine"; }; };
    common = { term_truecolor = true; };
  };

  # https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua
  home.file.".config/powerline/colors.json".text = builtins.toJSON {
    colors = { rose = [ 252 "d7827e" ]; /* gray10 */ base = [ 16 "faf4ed" ]; /* black */ }
      // { overlay = [ 236 "f2e9e1" ]; /* gray2 */ } // { text = [ 247 "575279" ]; /* gray8 */ };
  };
}
