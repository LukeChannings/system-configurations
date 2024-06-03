{ lib, config, pkgs, ... }: {
  options.shell.nushell.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.shell.defaultShell == "nushell";
  };

  config = lib.mkIf config.shell.nushell.enable {
    home-manager.users.${config.user} = {

      # https://github.com/nix-community/home-manager/blob/master/modules/programs/nushell.nix
      programs.nushell = {
        package = pkgs.nushell;
        enable = true;
        envFile = { text = (builtins.readFile ./env.nu); };
        configFile = { text = (builtins.readFile ./config.nu); };
        loginFile = { text = (builtins.readFile ./login.nu); };
      };

      home.packages = [
        pkgs.nushellPlugins.formats
        # pkgs.nushellPlugins.plist
      ];
    };
  };
}
