{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    apps.chromium.enable = lib.mkEnableOption "Chromium";
  };

  config = lib.mkIf config.apps.chromium.enable {
    home-manager.users.${config.user}.programs.chromium = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgs.brewCasks.chromium else pkgs.chromium;
      extensions = [
        { "id" = "fmkadmapgofadopljbjfkapdkoienihi"; } # React Developer Tools
      ];
    };
  };
}
