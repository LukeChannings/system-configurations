{
  config,
  lib,
  pkgs,
  ...
}:
{

  options.shell.bat.enable = lib.mkEnableOption "bat";

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/bat.nix
  config.home-manager.users.${config.user}.programs.bat = lib.mkIf config.shell.bat.enable {
    enable = true;
    config = {
      theme = "OneHalfDark";
      style = "plain";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
