{ lib, config, pkgs, ... }: {

  options.shell.fish.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.shell.defaultShell == "fish";
  };

  config = lib.mkIf config.shell.fish.enable {
    home-manager.users.${config.user} = {

      # https://github.com/nix-community/home-manager/blob/master/modules/programs/fish.nix
      programs.fish = {
        enable = true;

        shellInit = ''
          set fish_greeting
        '';
        interactiveShellInit =
          lib.mkIf config.shell.starship.enable "enable_transience";

        functions = {
          # https://fishshell.com/docs/current/interactive.html#vi-mode-commands
          fish_user_key_bindings = ''
            fish_default_key_bindings -M insert

            fish_vi_key_bindings --no-erase insert
          '';
          mcat = ''
            if file --mime-type $argv | grep -qF image/
               chafa -f iterm -s $FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES $argv
            else
               bat --color always --style numbers --theme TwoDark --line-range :200 $argv
            end'';
          fdz =
            "fd --type f --hidden --follow --exclude .git --color=always | fzf --ansi --multi --preview='mcat {}'";
        };

        # This fixes a bug with path ordering
        # See: https://github.com/LnL7/nix-darwin/issues/122
        loginShellInit = lib.mkIf pkgs.stdenv.isDarwin (let
          dquote = str: ''"'' + str + ''"'';

          makeBinPathList = map (path: path + "/bin");
        in ''
          fish_add_path --move --prepend --path ${
            lib.concatMapStringsSep " " dquote
            (makeBinPathList config.environment.profiles)
          }
          set fish_user_paths $fish_user_paths
        '');
      };
    };

    programs.fish.enable = true;
  };
}
