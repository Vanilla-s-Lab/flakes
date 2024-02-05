{ pkgs, config, inputs, system, lib, nixosConfig, generated, ... }: with inputs;
let pkgs_besttrace = pkgs.callPackage ../packages/besttrace.nix { }; in
{
  programs.go.enable = true;

  # https://github.com/longld/peda/issues/108
  # https://sourceware.org/gdb/onlinedocs/gdb/Command-History.html
  home.file.".gdbinit".text = ''
    source ${generated."longld_peda".src}/peda.py
    pset option autosave 'off'
  '';


  home.file.".npmrc".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.dot-npmrc.path;

  home.file."go".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/go";

  home.file.".wrangler".source = config.lib.file.mkOutOfStoreSymlink "/persistent/dot/wrangler";
  home.file.".config/.wrangler/".source = config.lib.file.mkOutOfStoreSymlink "/persistent/dot/config/dot/wrangler";
  home.file.".terraform.d".source = config.lib.file.mkOutOfStoreSymlink "/persistent/dot/terraform.d";

  home.file.".mc".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/mc";

  home.packages = with inputs; [
    pkgs.salt

    # https://nixos.wiki/wiki/Python
    (pkgs.python3.withPackages (ps: with ps; [
      setuptools
      pip

      elasticsearch
      elastic-transport
      peewee
      pymysql
    ]))

    pkgs.poetry

    pkgs.minio-client
    pkgs.ansible

    nixosConfig.boot.kernelPackages.perf
    (pkgs.gdb.override { pythonSupport = true; })

    pkgs.tcpdump
    pkgs.openssl

    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.ruby-mine
    pkgs.ruby

    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.rider

    pkgs.wine
    pkgs.mono
    pkgs.dotnet-sdk

    pkgs.jetbrains.clion

    pkgs.rustup
    pkgs.cargo-outdated

    pkgs.evcxr

    pkgs.gcc
    pkgs.cmake

    # pkgs.bintools
    pkgs.patchelf

    pkgs.talosctl

    pkgs.jetbrains.datagrip

    pkgs.docker-compose
    pkgs.podman-compose

    pkgs.jetbrains.webstorm
    pkgs.jetbrains.gateway

    pkgs.jetbrains.goland

    pkgs.nodejs
    pkgs.nodePackages.npm

    pkgs.nodePackages.wrangler
    pkgs.terraform
    pkgs.deploy-rs

    pkgs.nodePackages.npm-check-updates

    pkgs.dig
    pkgs.dogdns

    # https://wiki.archlinux.org/title/default_applications#xdg-open
    pkgs.perlPackages.FileMimeInfo

    pkgs.mtr
    pkgs.traceroute
    pkgs_besttrace

    pkgs.whois
    pkgs.curl

    pkgs.htop

    pkgs.powertop
    (pkgs.hwloc.override {
      x11Support = true;
    })

    pkgs.nvfetcher

    pkgs.wget

    pkgs.stress
    pkgs.sysstat
    pkgs.sysbench
    pkgs.pstree

    pkgs.dmidecode
    pkgs.lshw

    pkgs.ltrace

    # https://superuser.com/questions/1193701
    pkgs.jc # pkgs.jq | Use jc -p instead!

    (pkgs.procps.overrideAttrs (old: {
      # doCheck = false;
      configureFlags = old.configureFlags
        ++ [ "--enable-watch8bit" ];
    }))

    pkgs.ethtool
    pkgs.lynis

    pkgs.dsniff
    pkgs.conntrack-tools

    pkgs.smartmontools
    pkgs.pcstat

    pkgs.nix-tree

    pkgs.nmap
    pkgs.metasploit

    pkgs.jq
    pkgs.file

    pkgs.aircrack-ng
    pkgs.wirelesstools
    pkgs.hcxtools
  ];

  home.file.".local/share/containers".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/containers";

  home.file.".rustup".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/rustup";

  home.sessionPath = [
    "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin"
  ];

  home.file.".cache/JetBrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/JetBrains";

  home.file.".config/JetBrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/JetBrains";

  # https://nixos.wiki/wiki/Impermanence
  imports = [
    impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persistent" = {
    directories = [ ".local/share/JetBrains" ];
    allowOther = true;
  };

  home.file.".java/.userPrefs/jetbrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/java/dot/userPrefs/jetbrains";
}
