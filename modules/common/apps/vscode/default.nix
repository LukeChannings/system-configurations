{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.apps.vscode = {
    enable = lib.mkEnableOption "Visual Studio Code";
  };

  config = lib.mkIf config.apps.vscode.enable {
    home-manager.users.${config.user} =
      let
        vscode = pkgs.vscodium;
      in
      {
        home = {
          packages = [
            (pkgs.writeShellScriptBin "code" ''
              ${vscode}/Applications/VSCodium.app/Contents/MacOS/Electron $@
            '')
          ];
        };

        programs.vscode = {
          enable = true;

          package = vscode;
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          mutableExtensionsDir = false;

          userSettings = lib.importJSON ./settings.json;

          extensions = with pkgs.vscode-extensions; [
            zhuangtongfa.material-theme
            mkhl.direnv
            editorconfig.editorconfig
            redhat.vscode-yaml
            redhat.vscode-xml
            streetsidesoftware.code-spell-checker
            eamodio.gitlens
            tamasfe.even-better-toml
          ];

          keybindings = [
            {
              key = "cmd+j";
              command = "editor.action.joinLines";
            }
            {
              key = "cmd+k cmd+l";
              command = "editor.action.transformToLowercase";
              when = "editorTextFocus";
            }
          ];
        };
      };
  };
}
