{ config, lib, ... }:
{
  options.shell.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf config.shell.zoxide.enable {
    home-manager.users.${config.user}.programs.zoxide = {
      enable = true;

      options = [ "--cmd cd" ];
    };
  };
}
