{ config, lib, ... }:
{
  options.shell.atuin.enable = lib.mkEnableOption "atuin";

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/atuin.nix
  config = lib.mkIf config.shell.atuin.enable {
    home-manager.users.${config.user}.programs.atuin = {
      enable = true;
      # https://docs.atuin.sh/configuration/config/
      settings = {
        auto_sync = true;
        workspaces = true;
        ctrl_n_shortcuts = true;
        dialect = "uk";
        filter_mode = "host";
        filter_mode_shell_up_key_binding = "directory";
        style = "compact";
        inline_height = 5;
        show_help = false;
        enter_accept = true;

        sync = {
          records = true;
        };
      };
    };
  };
}
