{ pkgs, config, inputs, system, lib, nixosConfig, ... }: with inputs;
let pkgsJB = import inputs.nixpkgs-jetbrains
  { inherit system; config.allowUnfree = true; }; in
{
  home.packages = with inputs; [
    # (pkgs.python3.withPackages (p: with p; [ pygobject3 ]
    #   ++ [ pip setuptools ] ++ [ mysql-connector XlsxWriter pandas ]
    #   ++ [ requests faker ] ++ [ pillow ] ++ [ urllib3 grequests ]
    #   ++ [ fastapi uvicorn pydantic ] ++ [ cryptography ] ++ [ openpyxl ]))

    (pkgs.python3.withPackages
      # https://docs.ansible.com/ansible/latest/collections/ansible/builtin/pip_module.html
      (p: with p; [ openpyxl mysql-connector ] ++ [ pip virtualenv setuptools ]
        ++ [ pyqt5 ] ++ [ matplotlib numpy pytesseract ]))

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
    pkgs.kubectl

    pkgs.jetbrains.datagrip

    pkgs.docker-compose
    pkgs.podman-compose

    pkgs.jetbrains.webstorm

    pkgs.nodejs
    pkgs.nodePackages.npm

    pkgs.gradle

    pkgs.kubectl-tree

    pkgs.dig

    # https://wiki.archlinux.org/title/default_applications#xdg-open
    pkgs.perlPackages.FileMimeInfo

    pkgs.kubernetes-helm

    # pkgs.terraform-full
    pkgs.terraform

    pkgs.azure-cli
    pkgs.azure-storage-azcopy

    deploy-rs.defaultPackage."${system}"

    pkgs.redis

    pkgs.mtr
    pkgs.traceroute

    pkgs.whois
    pkgs.curl

    # Use sudo instead of adjust kernel.perf_event_paranoid!
    # nixosConfig.boot.kernelPackages.perf
    nixosConfig.boot.kernelPackages.bcc
    # nixosConfig.boot.kernelPackages.bpftrace
    nixosConfig.boot.kernelPackages.systemtap
    # https://vstinner.github.io/intel-cpus.html
    nixosConfig.boot.kernelPackages.turbostat
    nixosConfig.boot.kernelPackages.cpupower
    pkgs.flamegraph
    pkgs.msr-tools

    pkgs.powertop
    (pkgs.hwloc.override {
      x11Support = true;
    })

    inputs.nvfetcher.defaultPackage."${system}"

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

    pkgs.ansible
  ]; # ++ [ pkgs.pkg-config ];
  # home.sessionVariables = {
  #   PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  # };

  # https://github.com/containers/podman/blob/main/troubleshooting.md
  # podman/vendor/github.com/containers/storage/storage.conf
  home.file.".config/containers/storage.conf".text = ''
    [storage.options]
    mount_program = "${pkgs.fuse-overlayfs}/bin/fuse-overlayfs"

    [storage]
    driver = "overlay"
  '';

  home.file.".local/share/containers".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/containers";

  home.file.".azure".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/azure";

  home.file.".terraform.d".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/terraform.d";

  home.file.".gradle".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/gradle";

  programs.fish.interactiveShellInit = ''
    kubectl completion fish | source
  '';

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
