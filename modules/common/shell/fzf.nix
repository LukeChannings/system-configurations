{lib, config, ...}:
{
  options.shell.fzf.enable = lib.mkEnableOption "fuzzy finder";

  config = lib.mkIf config.shell.fzf.enable {
    home-manager.users.${config.user}.programs = {
      fzf.enable = true;
      fd.enable = true;
    };
  };
}
