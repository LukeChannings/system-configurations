{ config, lib, ... }: {
  options.shell.atuin.enable = lib.mkEnableOption "atuin";

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/atuin.nix
  config = lib.mkIf config.shell.atuin.enable {
    home-manager.users.${config.user}.programs.atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      # https://docs.atuin.sh/configuration/config/
      settings = {
        auto_sync = false;
        workspaced = true;
        ctrl_n_shortcuts = true;
        dialect = "uk";
        filter_mode = "host";
        style = "compact";
        inline_height = 5;
        show_help = false;

        sync = {
          records = true;
        };
    };
      };
    };
}
