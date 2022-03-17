{ pkgs, pkgsUnstable, config, ... }:
{
  home.packages = [
    (pkgs.python3.withPackages (p: with p; [ pygobject3 ]
      ++ [ pip setuptools ] ++ [ mysql-connector XlsxWriter pandas ]
      ++ [ requests faker ] ++ [ pillow ]))

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
  ];

  home.file.".docker/config.json".text = builtins.toJSON {
    "proxies" = {
      "default" = {
        "httpProxy" = "http://127.0.0.1:8889";
        "httpsProxy" = "https://127.0.0.1:8889";
      };
    };
  };

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
