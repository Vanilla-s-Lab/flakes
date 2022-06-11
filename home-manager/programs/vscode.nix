{ pkgs, ... }:
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
let vscExt = name: (pkgs.vscode-utils.buildVscodeExtension rec {
  inherit name; src = generated."\"${name}\"".src;
  vscodeExtUniqueId = name;
}); in
{
  programs.vscode.enable = true;

  # https://github.com/nix-community/home-manager/issues/2798
  programs.vscode.mutableExtensionsDir = false;

  programs.vscode.extensions = [ (vscExt "GitHub.copilot") (vscExt "GitHub.copilot-labs") ]
    # https://material-theme.com/docs/acknowledgements/#material-icon-theme-for-visual-studio-code
    ++ [ (vscExt "unthrottled.doki-theme") (vscExt "PKief.material-icon-theme") ];

  # https://code.visualstudio.com/docs/supporting/FAQ

  programs.vscode.userSettings = {
    "telemetry.telemetryLevel" = "off";
    "workbench.enableExperiments" = false;

    "update.mode" = "none";
    "extensions.autoUpdate" = false;

    # https://github.com/microsoft/vscode/issues/128454
    "editor.inlineSuggest.enabled" = true;
    "github.copilot.enable" = ({ "*" = true; } // # Enable All
      { "yaml" = true; "plaintext" = true; "markdown" = true; });

    # https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme
    "workbench.iconTheme" = "material-icon-theme";
    # https://marketplace.visualstudio.com/items?itemName=unthrottled.doki-theme
    "workbench.colorTheme" = "e828aaae-aa8c-4084-8993-d64697146930";
  };

  home.file.".vscode/argv.json".text = builtins.toJSON {
    "enable-crash-reporter" = false;
  };
}
