{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    users.knownUsers = [ config.user ];

    users.users.${config.user} = {
      home = config.homePath;
      uid = config.userId;
    };

    users.users.root = {
      home = "/var/root";
    };

    home-manager.users.${config.user} = (
      { lib, config, ... }:
      {
        programs.home-manager.enable = true;
        home.packages =
          (with pkgs.brewCasks; [
            arc
            
            utm
            
            postman
            tableplus
            bonjour-browser

            raycast
            maccy
            swish
            contexts
            hot
            suspicious-package
            monitorcontrol
            the-unarchiver
            apparency
          ]);
      }
    );
  };
}
