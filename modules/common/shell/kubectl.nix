{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    shell.kubectl.enable = lib.mkEnableOption "kubectl";
    shell.kubectl.k.enable = lib.mkEnableOption "kubectl";
  };

  config = lib.mkIf config.shell.kubectl.enable {
    home-manager.users.${config.user}.home = {
      packages = [ pkgs.kubectl ];

      shellAliases = lib.mkIf config.shell.kubectl.k.enable { k = "kubectl"; };
    };
  };
}
