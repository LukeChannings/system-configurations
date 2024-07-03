{lib, config, ...}: with lib; with types; {
  options = {
    apps = {
      wezterm.enable = mkEnableOption "WezTerm";
      vim.enable = mkEnableOption "vim";
      helix.enable = mkEnableOption "Helix editor";
      vscode.enable = mkEnableOption "Visual Studio Code";
      extra = mkOption {
        type = listOf package;
        description = "Additional apps to install";
        default = [];
      };
    };
  };

  imports = [
    ./wezterm
    ./vim
    ./helix
    ./vscode
  ];

  config = {
    home-manager.users.${config.user}.home.packages = config.apps.extra;
  };
}
