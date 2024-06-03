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
      uid = 501;
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
            hot
            suspicious-package
            telegram
            utm
            apparency
            plexamp
            mqttx
            raycast
            the-unarchiver
            postman
            anki
            blender
            tableplus
            swish
            # doxie
            contexts
            arc
            # betterdisplay
            monitorcontrol
            bonjour-browser
            # docker
            # zoom

            # Pro Apps
            audio-hijack
          ])
          ++ (with pkgs; [
            jetbrains.idea-ultimate
            docker_26
            zoom-us
          ]);
      }
    );
  };
}
