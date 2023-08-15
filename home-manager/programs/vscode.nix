{ pkgs, nix-vscode-extensions, system, ... }:
{
  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;

  programs.vscode.extensions = with nix-vscode-extensions; [
    extensions."${system}".vscode-marketplace.piousdeer.adwaita-theme
  ];

  # https://github.com/piousdeer/vscode-adwaita#suggested-settings
  programs.vscode.userSettings = {
    "window.titleBarStyle" = "custom";
    "window.commandCenter" = true;
    "window.autoDetectColorScheme" = true;
    "workbench.preferredDarkColorTheme" = "Adwaita Dark";
    "workbench.preferredLightColorTheme" = "Adwaita Light";
    "workbench.productIconTheme" = "adwaita";
    "editor.renderLineHighlight" = "none";
    "workbench.iconTheme" = null;
    "workbench.tree.indent" = 12;
  };
}
