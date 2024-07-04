{ config, lib, ... }:
{
  options.apps.wezterm.enable = lib.mkEnableOption "WezTerm";

  config = lib.mkIf config.apps.wezterm.enable {
    home-manager.users.${config.user}.programs.wezterm =
      let
        multiplexing_name = (lib.toLower ("${config.networking.hostName}_${config.user}"));
      in
      {
        enable = true;
        extraConfig = builtins.replaceStrings [ "__unix_socket__" ] [ multiplexing_name ] (
          builtins.readFile ./wezterm.lua
        );
      };
  };
}
