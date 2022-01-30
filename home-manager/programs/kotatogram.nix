{ pkgs, config, ... }:
{
  home.packages = [
    pkgs.nur.repos.ilya-fedin.kotatogram-desktop
    (pkgs.makeAutostartItem {
      name = "kotatogramdesktop";
      package = pkgs.nur.repos.ilya-fedin.kotatogram-desktop;
    })
  ];

  home.file.".local/share/KotatogramDesktop".source =
    config.lib.file.mkOutOfStoreSymlink
      "/persistent/dot/local/share/KotatogramDesktop";
}
