{ lib, pkgs, config, ... }:
let enable_feature = feature_list: builtins.listToAttrs
  (lib.lists.forEach feature_list # https://nixos.org/manual/nix/stable/expressions/builtins.html
    (x: { name = x; value = { disabled = false; }; })); in

let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
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
  };

  # https://github.com/fish-shell/fish-shell
  programs.fish.enable = true;

  programs.fish.functions = {
    "no_proxy".body = "set -e all_proxy ftp_proxy https_proxy http_proxy no_proxy rsync_proxy";
    "volume_67".body = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.67"; # GitLab - PipeWire - issues/976.
    "ssh_azure".body = "ssh root@20.24.195.187"; # Fail2ban enable! Make sure Yubikeys already plugged in!
  };

  # https://github.com/blackjid/plugin-kubectl
  programs.fish.plugins = [
    rec { name = "plugin-kubectl"; src = generated."${name}".src; }
    # rec { name = "Boxfish"; src = generated."${name}".src; }
  ];

  home.packages = [
    pkgs.nur.repos.linyinfeng.fishPlugins.git
    pkgs.nur.repos.linyinfeng.fishPlugins.bang-bang
    pkgs.fishPlugins.pisces
    pkgs.any-nix-shell

    # https://github.com/sharkdp/fd
    pkgs.fd
    # https://github.com/BurntSushi/ripgrep
    pkgs.ripgrep

    # https://github.com/MidAutumnMoon/Boxfish
    # pkgs.bubblewrap
  ];

  home.file.".config/nushell/env.nu".text = "";
  home.file.".config/nushell/config.nu".text = "";

  # https://github.com/jhillyerd/plugin-git
  home.activation."fishPlugins.git" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      ''fish -c "__git.init" || true'';

  # https://github.com/blackjid/plugin-kubectl/blob/master/hooks/install.fish
  home.activation."plugin-kubectl" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      ''fish -c "__kubectl.init" || true'';

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
      ''fish -c "rose_pine dawn" > /dev/null || true'';

  # https://github.com/nix-community/nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.tmux.enable = true;
  programs.nushell.enable = true;
  programs.nushell.package = pkgs.nushell;
}
