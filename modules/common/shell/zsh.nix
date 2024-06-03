{lib, config, ...}:
{
  options.shell.zsh.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.shell.defaultShell == "zsh";
  };

  config = lib.mkIf config.shell.zsh.enable {
    home-manager.users.${config.user}.programs.zsh = {
      enable = true;
    };
  };
}
