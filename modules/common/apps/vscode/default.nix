{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.apps.vscode.enable {
    home-manager.users.${config.user}.programs.vscode = {
      enable = true;

      package = pkgs.vscodium;
      enableUpdateCheck = false;
      userSettings = {
        "editor.fontSize" = 16;
        "explorer.confirmDelete" = false;
        "editor.rulers" = [ 120 ];
        "editor.multiCursorModifier" = "ctrlCmd";
        "workbench.colorTheme" = "One Dark Pro Flat";
        "editor.suggestSelection" = "first";
        "editor.fontFamily" = "RecMonoLinear-Regular";
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "notebook.markup.fontSize" = 14;
        "terminal.integrated.fontSize" = 14;
        "editor.renderWhitespace" = "all";
        "emmet.showSuggestionsAsSnippets" = true;
        "editor.inlineSuggest.enabled" = true;
        "redhat.telemetry.enabled" = false;
        "editor.fontLigatures" = true;
        "editor.snippetSuggestions" = "bottom";
        "extensions.ignoreRecommendations" = true;
        "cSpell.language" = "en;en-GB";
        "workbench.startupEditor" = "none";
        "window.commandCenter" = false;
        "terminal.integrated.shellIntegration.enabled" = false;
        "workbench.editor.empty.hint" = "hidden";
        "search.quickOpen.history.filterSortOrder" = "recency";
        "extensions.autoCheckUpdates" = false;
        "nix.enableLanguageServer" = true;
        "gitlens.showWelcomeOnInstall" = false;
        "gitlens.showWhatsNewAfterUpgrades" = false;
        "gitlens.plusFeatures.enabled" = false;
        "[markdown]" = {
          "editor.wordWrap" = "on";
        };
      };

      extensions = with pkgs.vscode-extensions; [
        mkhl.direnv
        editorconfig.editorconfig
        redhat.vscode-yaml
        redhat.vscode-xml
        streetsidesoftware.code-spell-checker
        eamodio.gitlens
      ];
    };
  };
}
