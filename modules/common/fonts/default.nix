{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.fonts.enable = lib.mkEnableOption "fonts";

  config = lib.mkIf config.fonts.enable {
    home-manager.users.${config.user} = {
      fonts.fontconfig.enable = true;
      home.packages = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "Recursive"
            "Hasklig"
            "VictorMono"
            "FiraCode"
            "IosevkaTerm"
          ];
        })
      ];
    };
  };
}
