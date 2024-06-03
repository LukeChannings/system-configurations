{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  vscodeExtensions = with pkgs.vscode-extensions; [ jnoortheen.nix-ide ];
in
{
  packages = with pkgs; [
    stylua
    shfmt
    shellcheck
    nixfmt-rfc-style
  ];

  scripts = {
    install-workspace-extensions.exec =
      let
        installWorkspaceVSCodeExtensions =
          with builtins;
          extensions: ''
            rm -rf .vscode/extensions
            mkdir -p .vscode/extensions
            ${concatStringsSep "\n" (
              map (extension: "ln -s ${extension}/share/vscode/extensions/* .vscode/extensions/") extensions
            )}
          '';
      in
      installWorkspaceVSCodeExtensions vscodeExtensions;
  };

  languages.nix.enable = true;

  pre-commit.hooks.shellcheck.enable = true;
}
