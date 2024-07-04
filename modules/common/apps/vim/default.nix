{lib, config, pkgs, ...}:
{

  options.apps.vim.enable = lib.mkEnableOption "Vim";

  config = lib.mkIf config.apps.vim.enable {
    home-manager.users.${config.user} = {
      programs.vim = {
        enable = true;

        defaultEditor = config.shell.defaultEditor == "vim";

        plugins = with pkgs.vimPlugins; [
          editorconfig-vim
          polyglot
          targets-vim
          onedark-vim
          nerdcommenter
          fzf-vim
          gitgutter
          lightline-vim
          ale
          vim-lsp-ale
        ];

        extraConfig = (builtins.readFile ./.vimrc);
      };
    };
  };
}
