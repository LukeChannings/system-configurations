{lib, config, ...}:
{
  options.shell.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.shell.direnv.enable {
    home-manager.users.${config.user}.programs.direnv = {
      enable = true;
      config = {
        hide_env_diff = true;
      };
      nix-direnv.enable = true;
    };
  };
}
