{ lib, config, ...  }:
{
  options.shell.htop.enable = lib.mkEnableOption "htop";

  config = {
    home-manager.users.${config.user} = {
      programs.htop= {
        enable = true;
      };
    };
  };
}
