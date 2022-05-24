{ lib, pkgs, config, ... }:
let myh2o_backup = "098ed3541f61e477d9c9185fad15605b91644dcc34819ac700585abc27fba113"; in
let Videos = "59682d0a8bc570a588c66fff6d2f6b03ef4afc5e9c2eac86ee770beafa61328f"; in
let chaoxing_auto_sign = "187e3c25d7c87f426bee0324ad1ad5a285360a1a4947cbc9983147e3b9573880"; in
let azure-nix = "1bd03d69e4884dcfa883f44694cf239592f6cb21ca25ea6c485f5dd550eaef9a"; in
let Digital_Image_Processing = "fb8675f058d5c5216062b3f132802d6311e3bad75b78b9844e30a368faabd1e4"; in

let enable_feature = feature_list: builtins.listToAttrs
  (lib.lists.forEach feature_list # https://nixos.org/manual/nix/stable/expressions/builtins.html
    (x: { name = x; value = { disabled = false; }; })); in

let oh-my-posh = pkgs.callPackage ../packages/oh-my-posh.nix { }; in
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in

# WeChat ID: My_Aim_Sucks
let wxid = "wxid_2tafg8vy4onr22"; in
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
    "volume_67".body = "amixer sset Master 67%"; # https://unix.stackexchange.com/questions/32206
    "ssh_azure".body = "ssh root@20.24.195.187"; # Fail2ban enable! Make sure Yubikeys already plugged in!
    "wechat_file".body = "open ~/.local/lib/wine-wechat/default/drive_c/WeChat Files/${wxid}/FileStorage/File";
  };

  # https://github.com/blackjid/plugin-kubectl
  programs.fish.plugins = [
    rec {
      name = "plugin-kubectl";
      src = pkgs.fetchgit {
        url = "https://github.com/blackjid/${name}";
        rev = "dd8012f3ebfb3ceec4c693f3cc12e4c1397ac9c8";
        hash = "sha256-wLeWzPJz5AmcSprq5lIcR+3onjL7uIFCM2zj71pL2rs=";
      };
    }
    rec {
      name = "Boxfish";
      src = pkgs.fetchgit {
        url = "https://github.com/MidAutumnMoon/${name}";
        rev = "38f6eb04f24e1795ed9b9d7dbf777903d4e0f5dd";
        hash = "sha256-gJcYNIbJXtysgno9cHA5UhMYxWVcwx22vtarK1TF3o4=";
      };
    }
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

    # https://github.com/nvbn/thefuck#installation=
    pkgs.thefuck

    # https://github.com/MidAutumnMoon/Boxfish
    pkgs.bubblewrap

    # https://ohmyposh.dev/docs/installation/prompt
    oh-my-posh
  ];

  home.file.".config/nushell/env.nu".source =
    "${pkgs.nushell.src}/docs/sample_config/default_config.nu";
  home.file.".config/nushell/kali.omp.json".source =
    "${generated.oh-my-posh.src}/themes/kali.omp.json";

  # https://github.com/nushell/nushell/pull/4966
  home.activation."prepare_dot_omp_for_nushell" =
    lib.hm.dag.entryAfter [ "dconfSettings" ]
      "oh-my-posh init nu --config ~/.config/nushell/kali.omp.json";

  # https://www.nushell.sh/book/3rdpartyprompts.html
  home.file.".config/nushell/config.nu".text =
    "source ~/.oh-my-posh.nu";

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

  # https://github.com/haslersn/any-nix-shell
  # https://github.com/nvbn/thefuck/wiki/Shell-aliases#fish=
  programs.fish.interactiveShellInit = ''
    any-nix-shell fish --info-right | source
    thefuck --alias | source
  '';

  # https://github.com/nix-community/nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.file.".local/share/direnv/allow/${myh2o_backup}".text =
    "/persistent/Documents/myh2o_backup/.envrc";
  home.file.".local/share/direnv/allow/${Videos}".text =
    "/persistent/Videos/.envrc";
  home.file.".local/share/direnv/allow/${chaoxing_auto_sign}".text =
    "/persistent/Documents/chaoxing_auto_sign/.envrc";
  home.file.".local/share/direnv/allow/${azure-nix}".text =
    "/persistent/Projects/azure-nix/.envrc";
  home.file.".local/share/direnv/allow/${Digital_Image_Processing}".text =
    "/persistent/Projects/Digital_Image_Processing/.envrc";

  programs.tmux.enable = true;
  programs.nushell.enable = true;
}
