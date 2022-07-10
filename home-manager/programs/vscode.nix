{ pkgs, ... }:
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
let vscExt = name: (pkgs.vscode-utils.buildVscodeExtension rec {
  inherit name; src = generated."\"${name}\"".src;
  vscodeExtUniqueId = name;
}); in
{
  programs.vscode.enable = true;
  # https://nixos.wiki/wiki/Visual_Studio_Code#Use_VSCode_extensions_without_additional_configuration
  # programs.vscode.package = pkgs.vscode-fhsWithPackages (ps: with ps; [ rust-analyzer ]);

  # https://github.com/nix-community/home-manager/issues/2798
  programs.vscode.mutableExtensionsDir = false;

  programs.vscode.extensions = [ (vscExt "GitHub.copilot") (vscExt "GitHub.copilot-labs") ]
    # https://material-theme.com/docs/acknowledgements/#material-icon-theme-for-visual-studio-code
    ++ [ (vscExt "unthrottled.doki-theme") (vscExt "PKief.material-icon-theme") ]
    ++ [ (vscExt "redhat.ansible") (vscExt "ms-python.python") (vscExt "redhat.vscode-yaml") ];

  # https://code.visualstudio.com/docs/supporting/FAQ

  programs.vscode.userSettings = {
    "telemetry.telemetryLevel" = "off";
    "workbench.enableExperiments" = false;

    "update.mode" = "none";
    "extensions.autoUpdate" = false;

    # https://github.com/microsoft/vscode/issues/128454
    "editor.inlineSuggest.enabled" = true;
    "github.copilot.enable" = ({ "*" = true; } // # Enable all.
      { "yaml" = true; "plaintext" = true; "markdown" = true; });

    # https://marketplace.visualstudio.com/items?itemName=unthrottled.doki-theme
    "workbench.colorTheme" = "e828aaae-aa8c-4084-8993-d64697146930";
    # https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme
    "workbench.iconTheme" = "material-icon-theme";
  };

  home.file.".vscode/argv.json".text = builtins.toJSON {
    "enable-crash-reporter" = false;
  };
}
