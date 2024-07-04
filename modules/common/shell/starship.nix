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
            success_symbol = "[λ](bold green)";
            error_symbol = "[λ](bold red)";
          };
          nix_shell = {
            disabled = false;
            format = "[$symbol](bold blue) ";
          };
          directory = {
            fish_style_pwd_dir_length = 2;
          };
          git_branch = {
            format = "[$symbol$branch(:$remote_branch)]($style)";
            ignore_branches = ["master" "main"];
          };
          cmd_duration = {
            disabled = false;
          };
        };
    };
  };
}
