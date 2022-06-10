{ pkgs, ... }:
{
  programs.vscode.enable = true;
  programs.vscode.package = (pkgs.vscode-with-extensions.override {
    vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace
      (builtins.fromJSON (builtins.readFile ../../vscode-extensions.json));
  });
}
