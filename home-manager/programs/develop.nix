{ pkgs, config, inputs, system, ... }:
let pkgsJB = import inputs.nixpkgs-jetbrains
  { inherit system; config.allowUnfree = true; }; in
let pkgs_jetbrains = pkgsJB.jetbrains; in
let pkgs_nodogsplash = pkgs.callPackage ../packages/nodogsplash.nix { }; in
{
  home.packages = with inputs; [
    # (pkgs.python3.withPackages (p: with p; [ pygobject3 ]
    #   ++ [ pip setuptools ] ++ [ mysql-connector XlsxWriter pandas ]
    #   ++ [ requests faker ] ++ [ pillow ] ++ [ urllib3 grequests ]
    #   ++ [ fastapi uvicorn pydantic ] ++ [ cryptography ] ++ [ openpyxl ]))

    (pkgs.python3.withPackages
      (p: with p; [ openpyxl mysql-connector ]))

    pkgs_jetbrains.pycharm-professional
    pkgs_jetbrains.idea-ultimate
    pkgs_jetbrains.rider

    pkgs.dotnet-sdk
    pkgs.mono

    pkgs_jetbrains.clion

    pkgs.rustup
    pkgs.gcc

    pkgs.android-studio

    pkgs.minikube
    pkgs.kubectl

    pkgs_jetbrains.datagrip

    pkgs.docker-compose
    pkgs.podman-compose

    pkgs_jetbrains.webstorm

    pkgs.nodejs
    pkgs.nodePackages.npm

    pkgs.gradle

    pkgs.kubectl-tree

    nvem.defaultPackage."${system}"

    pkgs.dig

    pkgs_nodogsplash

    deploy-rs.packages."${system}".deploy-rs

    # https://wiki.archlinux.org/title/default_applications#xdg-open
    pkgs.perlPackages.FileMimeInfo
  ];

  # https://minikube.sigs.k8s.io/docs/handbook/config/
  home.sessionVariables = { MINIKUBE_IN_STYLE = "false"; };

  home.file.".minikube".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/minikube";

  home.file.".gradle".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/gradle";

  programs.fish.interactiveShellInit = ''
    kubectl completion fish | source
  '';

  home.file."Android".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/Android";

  home.file.".cache/Google".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/cache/Google";

  home.file.".config/Google".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/config/Google";

  home.file.".local/share/Google".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/Google";

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

  programs.vscode.enable = true;
  programs.vscode.package = (pkgs.vscode-with-extensions.override {
    vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace
      (builtins.fromJSON (builtins.readFile ../vscode-extensions.json));
  }).overrideAttrs (old: { pname = "vscode"; });

  programs.vscode.userSettings = {
    # https://github.com/piousdeer/vscode-adwaita#suggested-settings=
    "workbench.colorTheme" = "Adwaita Light"; # macOS one day xD
    # "workbench.preferredLightColorTheme" = "Adwaita Light";
    # "workbench.preferredDarkColorTheme" = "Adwaita Dark";

    # https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-telemetry-reporting
    "telemetry.telemetryLevel" = "off"; # Fuck
    # https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-experiments
    "workbench.enableExperiments" = false; # You
    # https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-crash-reporting
    "enable-crash-reporter" = false; # Microsoft

    # https://code.visualstudio.com/docs/supporting/faq#_how-do-i-opt-out-of-vs-code-autoupdates=
    "update.mode" = "none";
    # https://code.visualstudio.com/docs/supporting/faq#_opt-out-of-extension-updates
    "extensions.autoUpdate" = false;
  };
}
