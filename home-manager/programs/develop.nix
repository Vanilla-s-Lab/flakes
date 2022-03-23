{ pkgs, pkgsUnstable, config, ... }:
{
  home.packages = [
    (pkgs.python3.withPackages (p: with p; [ pygobject3 ]
      ++ [ pip setuptools ] ++ [ mysql-connector XlsxWriter pandas ]
      ++ [ requests faker ] ++ [ pillow ] ++ [ urllib3 grequests ]))

    pkgsUnstable.jetbrains.pycharm-professional
    pkgsUnstable.jetbrains.idea-ultimate
    pkgsUnstable.jetbrains.rider

    pkgs.dotnet-sdk
    pkgs.mono

    pkgsUnstable.jetbrains.clion

    pkgs.rustup
    pkgs.gcc

    pkgs.android-studio

    pkgs.minikube
    pkgsUnstable.kubectl

    pkgsUnstable.jetbrains.datagrip

    pkgs.docker-compose
    pkgs.podman-compose

    pkgsUnstable.jetbrains.webstorm

    pkgs.nodejs
    pkgs.nodePackages.npm

    pkgs.gradle
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
}
