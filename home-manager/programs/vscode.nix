{ pkgs, ... }:
{
  programs.vscode.enable = true;
  programs.vscode.package = ((pkgs.vscode-with-extensions.override {
    vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace
      (builtins.fromJSON (builtins.readFile ../../vscode-extensions.json));
  }).overrideAttrs (old: { pname = "vscode"; })); # Required by userSettings.

  # https://code.visualstudio.com/docs/supporting/FAQ

  programs.vscode.userSettings = {
    "telemetry.telemetryLevel" = "off";
    "workbench.enableExperiments" = false;

    "update.mode" = "none";
    "extensions.autoUpdate" = false;
  };

  home.file.".vscode/argv.json".text = builtins.toJSON {
    "enable-crash-reporter" = false;
  };
}
