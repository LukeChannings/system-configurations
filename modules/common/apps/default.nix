{ lib, config, ... }:
with lib;
with types;
{
  options = {
    apps = {
      extra = mkOption {
        type = listOf package;
        description = "Additional apps to install";
        default = [ ];
      };
    };
  };

  imports = [
    ./wezterm
    ./vim
    ./helix
    ./vscode
    ./chromium
  ];

  config = {
    home-manager.users.${config.user}.home.packages = config.apps.extra;
  };
}
