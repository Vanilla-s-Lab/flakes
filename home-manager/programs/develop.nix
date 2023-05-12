{ pkgs, config, inputs, system, lib, nixosConfig, generated, ... }: with inputs;
let copilot-agent-linux = pkgs.callPackage ../packages/copilot-agent-linux.nix { }; in
let pkgs_besttrace = pkgs.callPackage ../packages/besttrace.nix { }; in
let pkgs_ghtop = pkgs.callPackage ../packages/ghtop.nix { }; in

let pkgsUnstable = import nixos-unstable { inherit system; }; in
let pkgsUnstable_jetbrains_jdk = pkgsUnstable.jetbrains.jdk; in
{
  # https://github.com/longld/peda/issues/108
  # https://sourceware.org/gdb/onlinedocs/gdb/Command-History.html
  home.file.".gdbinit".text = ''
    source ${generated."\"longld/peda\"".src}/peda.py
    pset option autosave 'off'
  '';

  home.file."${".local/share/JetBrains/IntelliJIdea2022.3" +
    "/${copilot-agent-linux.pname}/copilot-agent/bin/${copilot-agent-linux.name}"}".source =
    "${copilot-agent-linux}/bin/${copilot-agent-linux.name}";

  home.file."${".local/share/JetBrains/PyCharm2022.3" +
    "/${copilot-agent-linux.pname}/copilot-agent/bin/${copilot-agent-linux.name}"}".source =
    "${copilot-agent-linux}/bin/${copilot-agent-linux.name}";

  home.file."${".local/share/JetBrains/CLion2022.3" +
    "/${copilot-agent-linux.pname}/copilot-agent/bin/${copilot-agent-linux.name}"}".source =
    "${copilot-agent-linux}/bin/${copilot-agent-linux.name}";

  home.file.".cargo".source = config.lib.file.mkOutOfStoreSymlink "/persistent/dot/cargo";

  home.file."${".local/share/JetBrains/WebStorm2022.3" +
    "/${copilot-agent-linux.pname}/copilot-agent/bin/${copilot-agent-linux.name}"}".source =
    "${copilot-agent-linux}/bin/${copilot-agent-linux.name}";

  home.file.".npmrc".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates.dot-npmrc.path;

  home.file."${".local/share/JetBrains/Rider${pkgs.jetbrains.rider.version}" +
    "/${copilot-agent-linux.pname}/copilot-agent/bin/${copilot-agent-linux.name}"}".source =
    "${copilot-agent-linux}/bin/${copilot-agent-linux.name}";
  home.file."${".local/share/JetBrains/DataGrip2022.2" +
    "/${copilot-agent-linux.pname}/copilot-agent/bin/${copilot-agent-linux.name}"}".source =
    "${copilot-agent-linux}/bin/${copilot-agent-linux.name}";

  home.file."${".local/share/JetBrains/GoLand2022.2" +
    "/${copilot-agent-linux.pname}/copilot-agent/bin/${copilot-agent-linux.name}"}".source =
    "${copilot-agent-linux}/bin/${copilot-agent-linux.name}";

  home.file."go".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/go";

  home.file.".wrangler".source = config.lib.file.mkOutOfStoreSymlink "/persistent/dot/wrangler";
  home.file.".config/.wrangler/".source = config.lib.file.mkOutOfStoreSymlink "/persistent/dot/config/dot/wrangler";
  home.file.".terraform.d".source = config.lib.file.mkOutOfStoreSymlink "/persistent/dot/terraform.d";

  programs.ssh.matchBlocks."linode-nix" = {
    host = "172.105.209.227";
    proxyCommand = "nc -x localhost:1089 %h %p";
  };


  home.file.".mc".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/mc";

  home.file.".fly/config.yml".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates."config.yml".path;

  home.packages = with inputs; [
    pkgs.salt

    # https://github.com/NixOS/nixpkgs/pull/231418
    # https://github.com/NixOS/nixpkgs/issues/86349
    (pkgs.flyctl.override {
      buildGoModule = args: pkgs.buildGoModule.override { go = pkgs.go_1_20; } (args // rec {
        version = "0.1.2";
        src = pkgs.fetchFromGitHub {
          owner = "superfly";
          repo = "flyctl";
          rev = "v${version}";
          hash = "sha256-0nassGiVjBb/KLMwj/DWSDdW/ymkIJSfoA6fdLyq8YE=";
        };

        vendorSha256 = "sha256-w/8cCtu+SKhooutKt810pnbGR1a3hWHjhNmzLVU0Zxk=";
      });
    })

    (pkgs.python3.withPackages
      (p: with p; [ setuptools pip ]))

    (pkgs.s3fs.overrideAttrs (old: {
      version = "unstable-2023-02-08";
      src = pkgs.fetchgit {
        url = "https://github.com/s3fs-fuse/s3fs-fuse.git";
        rev = "d1388ff446b74e82483f8a09b1d576cd958d4d64";
        hash = "sha256-3oQ3zSDsjmOiCqKuA6LJMAyIX07zF3ZJdkJPHqAOuN0=";
      };
    }))

    pkgs.minio-client
    pkgs.ansible

    nixosConfig.boot.kernelPackages.perf
    (pkgs.gdb.override { pythonSupport = true; })

    pkgs.tcpdump
    pkgs.openssl

    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.rider

    pkgs.wine
    pkgs.mono
    pkgs.dotnet-sdk

    # pkgs.jetbrains.clion
    (pkgs.jetbrains.clion.override {
      jdk = pkgsUnstable_jetbrains_jdk;
    })

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
    pkgs.go

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
    pkgs_ghtop

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

    pkgs.pmbootstrap
  ];

  home.file.".ghtop_token".source =
    config.lib.file.mkOutOfStoreSymlink
      "/run/secrets/ghtop_token/token";

  home.file.".config/pmbootstrap.cfg".source =
    pkgs.fetchurl {
      url = "https://gist.githubusercontent.com/VergeDX/5a34b1475bcc7283dd6d4f504b8251ea"
        + "/raw/c510625e1cc136e75027c8808615a02eb89682a6/pmbootstrap.cfg";
      hash = "sha256-muvILHZ4jMNbSuOq/TmuI+1/9R2EQAKCGgsVo5RILD8=";
    };

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
