{lib, config, ...}: {
  options.shell.starship.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.shell.starship.enable {
    home-manager.users.${config.user}.programs.starship = {
      enable = true;
      settings = {
          add_newline = false;
          format = lib.concatStrings [
            "$directory"
            "$character"
          ];
          right_format = lib.concatStrings [
            "$git_branch"
            "$git_status"
            "$nix_shell"
          ];
          scan_timeout = 10;
          character = {
            success_symbol = "λ";
            error_symbol = "λ";
          };
          nix_shell = {
            disabled = false;
          };
          directory = {
            fish_style_pwd_dir_length = 2;
          };
          git_branch = {
            format = "[$symbol$branch(:$remote_branch)]($style)";
            ignore_branches = ["master" "main"];
          };
        };
    };
  };
}
