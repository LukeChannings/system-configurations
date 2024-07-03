{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.apps.vscode.enable {
    home-manager.users.${config.user} =
      let
        vscode = pkgs.vscodium;
      in
      {
        home.packages = [
          (pkgs.writeShellScriptBin "code" ''
            ${vscode}/Applications/VSCodium.app/Contents/MacOS/Electron $@
          '')
        ];

        programs.vscode = {
          enable = true;

          package = vscode;
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          mutableExtensionsDir = false;

          userSettings = {
            "editor.fontFamily" = "Recursive Mn Lnr St";
            "editor.fontSize" = 16;
            "notebook.markup.fontSize" = 14;
            "terminal.integrated.fontSize" = 14;
            "editor.fontLigatures" = true;
            "explorer.confirmDelete" = false;
            "editor.rulers" = [ 120 ];
            "editor.multiCursorModifier" = "ctrlCmd";
            "workbench.colorTheme" = "One Dark Pro Flat";
            "editor.suggestSelection" = "first";
            "typescript.updateImportsOnFileMove.enabled" = "always";
            "editor.renderWhitespace" = "all";
            "emmet.showSuggestionsAsSnippets" = true;
            "editor.inlineSuggest.enabled" = true;
            "redhat.telemetry.enabled" = false;
            "editor.snippetSuggestions" = "bottom";
            "extensions.ignoreRecommendations" = true;
            "cSpell.language" = "en;en-GB";
            "workbench.startupEditor" = "none";
            "window.commandCenter" = false;
            "terminal.integrated.shellIntegration.enabled" = false;
            "workbench.editor.empty.hint" = "hidden";
            "search.quickOpen.history.filterSortOrder" = "recency";
            "gitlens.showWelcomeOnInstall" = false;
            "gitlens.showWhatsNewAfterUpgrades" = false;
            "gitlens.plusFeatures.enabled" = false;
            "[markdown]" = {
              "editor.wordWrap" = "on";
            };
          };

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
