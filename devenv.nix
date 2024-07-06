{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  vscodeExtensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    thenuprojectcontributors.vscode-nushell-lang
  ];
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
          extensions: # bash
          ''
            rm -rf .vscode/extensions
            mkdir -p .vscode/extensions
            ${concatStringsSep "\n" (
              map (extension: "cp -R ${extension}/share/vscode/extensions/* .vscode/extensions/") extensions
            )}

            chmod +rw -R .vscode/extensions

            for extension in $(ls .vscode/extensions); do
              extensionPath=".vscode/extensions/''${extension}"
              main="$(jq -r ".main" ''${extensionPath}/package.json)"

              if [ ! -e "''${extensionPath}/''${main}" ]; then
                echo "''${extension} entry point is missing"
                tmp="$(mktemp)"
                jq ".main = \"''${main}.js\"" "''${extensionPath}/package.json" > $tmp
                cat $tmp > "''${extensionPath}/package.json"
              fi
            done
          '';
      in
      installWorkspaceVSCodeExtensions vscodeExtensions;
  };

  languages.nix.enable = true;
}
