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

  programs.vscode.extensions = [
    (vscExt "GitHub.copilot")
    (vscExt "GitHub.copilot-labs")
  ];

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
  };

  home.file.".vscode/argv.json".text = builtins.toJSON {
    "enable-crash-reporter" = false;
  };
}
