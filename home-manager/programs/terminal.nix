{ lib, pkgs, config, generated, ... }:
let enable_feature = feature_list: builtins.listToAttrs
  (lib.lists.forEach feature_list # https://nixos.org/manual/nix/stable/expressions/builtins.html
    (x: { name = x; value = { disabled = false; }; })); in

let linode-nix = "8384794718e7179aa44ad91cd794e62ef2e99c9abd45b05bfd83b9c2e4a9fd7b"; in
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

  # https://github.com/wawa19933/fish-systemd
  programs.fish.plugins = pkgs.lib.singleton rec {
    name = "fish-systemd";
    src = generated."\"wawa19933/${name}\"".src;
  };

  programs.fish.functions = {
    "no_proxy".body = "set -e all_proxy ftp_proxy https_proxy http_proxy no_proxy rsync_proxy";
    "volume_67".body = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.67"; # GitLab - PipeWire - issues/976.
  };

  home.packages = [
    pkgs.nur.repos.linyinfeng.fishPlugins.git
    pkgs.nur.repos.linyinfeng.fishPlugins.bang-bang
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

  # https://github.com/jhillyerd/plugin-git
  home.activation."fishPlugins.git" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      ''fish -c "__git.init" || true'';

  # https://starship.rs/
  programs.starship.enable = true;
  # https://starship.rs/config/
  programs.starship.settings = (enable_feature
    ([ "git_metrics" "kubernetes" "memory_usage" ]
      ++ [ "shell" "status" "sudo" "time" ]));

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
      ''fish -c "rose_pine dawn" > /dev/null || true'';

  # https://github.com/nix-community/nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.file."/home/vanilla/.local/share/direnv/allow/${linode-nix}".text =
    "/persistent/Projects/linode-nix/.envrc";

  programs.kitty.enable = true;
  programs.kitty.extraConfig = "include rose-pine-dawn.conf";
  home.file.".config/kitty/rose-pine-dawn.conf".source =
    "${generated."\"rose-pine/kitty\"".src}/dist/rose-pine-dawn.conf";

  programs.tmux.enable = true;
  programs.tmux.shell = "${pkgs.fish}/bin/fish";

  # https://powerline.readthedocs.io/en/latest/usage/other.html
  home.file.".tmux.conf".text = ''source "${pkgs.powerline}/share/tmux/powerline.conf"'';

  # https://powerline.readthedocs.io/en/latest/configuration/reference.html#config-colors-colors
  # https://github.com/powerline/powerline/blob/develop/powerline/config_files/colorschemes/tmux/default.json
  home.file.".config/powerline/colorschemes/rose-pine.json".text = builtins.toJSON {
    name = "rose-pine";

    groups = {
      attached_clients = { attrs = [ ]; bg = "gray0"; fg = "gray8"; };
      background = { attrs = [ ]; bg = "gray0"; fg = "white"; };
    };
  };

  # All required args included.
  # `tmux -V`: tmux 3.2a; pkgs.powerline: Version: 2.8.2.
  home.file.".config/powerline/colorschemes/tmux/rose-pine.json".text = builtins.toJSON {
    groups = {
      active_window_status = { attrs = [ ]; bg = "gray0"; fg = "darkblue"; };
      activity_status = { attrs = [ ]; bg = "gray0"; fg = "yellow"; };
      bell_status = { attrs = [ ]; bg = "gray0"; fg = "red"; };
      session = { attrs = [ "bold" ]; bg = "gray90"; fg = "black"; };
      "session:prefix" = { attrs = [ "bold" ]; bg = "darkblue"; fg = "gray90"; };
      window = { attrs = [ ]; bg = "gray0"; fg = "gray6"; };
      "window:current" = { attrs = [ ]; bg = "darkblue"; fg = "mediumcyan"; };
      "window:divider" = { attrs = [ ]; bg = "gray0"; fg = "gray4"; };
      window_name = { attrs = [ "bold" ]; bg = "darkblue"; fg = "white"; };
      window_status = { attrs = [ ]; bg = "gray0"; fg = "gray70"; };
    };
  };

  # https://github.com/powerline/powerline/blob/develop/powerline/config_files/config.json
  home.file.".config/powerline/config.json".text = builtins.toJSON {
    ext = { tmux = { colorscheme = "rose-pine"; }; };
  };
}
