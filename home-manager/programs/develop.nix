{ pkgs, config, inputs, system, lib, nixosConfig, ... }: with inputs;
{
  home.file.".local/share/Zeal".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/Zeal";

  home.packages = with inputs; [
    pkgs.salt
    pkgs.zeal
    pkgs.python3Full

    nixosConfig.boot.kernelPackages.perf
    (pkgs.gdb.override { pythonSupport = true; })

    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.idea-ultimate
    pkgs.jetbrains.rider

    (lib.hiPrio pkgs.msbuild)
    pkgs.wine
    (lib.lowPrio pkgs.mono)
    pkgs.dotnet-sdk

    pkgs.jetbrains.clion

    pkgs.rustup
    pkgs.evcxr
    (lib.hiPrio pkgs.gcc)
    pkgs.bintools
    pkgs.patchelf

    pkgs.talosctl

    pkgs.jetbrains.datagrip

    pkgs.docker-compose
    pkgs.podman-compose

    pkgs.jetbrains.webstorm

    pkgs.nodejs
    pkgs.nodePackages.npm

    pkgs.dig

    # https://wiki.archlinux.org/title/default_applications#xdg-open
    pkgs.perlPackages.FileMimeInfo

    # pkgs.terraform-full
    pkgs.terraform

    deploy-rs.defaultPackage."${system}"

    pkgs.mtr
    pkgs.traceroute

    pkgs.whois
    pkgs.curl

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

  home.file.".config/pmbootstrap.cfg".source =
    pkgs.fetchurl {
      url = "https://gist.githubusercontent.com/VergeDX/5a34b1475bcc7283dd6d4f504b8251ea"
        + "/raw/c510625e1cc136e75027c8808615a02eb89682a6/pmbootstrap.cfg";
      hash = "sha256-muvILHZ4jMNbSuOq/TmuI+1/9R2EQAKCGgsVo5RILD8=";
    };

  home.file.".local/share/containers".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/containers";

  home.file.".terraform.d".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/terraform.d";

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

  home.file.".local/share/JetBrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/JetBrains";

  home.file.".java/.userPrefs/jetbrains".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/java/dot/userPrefs/jetbrains";
}
