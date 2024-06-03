{lib, ...}: {
  options = {
    apps = {
      wezterm.enable = lib.mkEnableOption "WezTerm";
      vim.enable = lib.mkEnableOption "vim";
      helix.enable = lib.mkEnableOption "Helix editor";
      vscode.enable = lib.mkEnableOption "Visual Studio Code";
    };
  };

  imports = [
    ./wezterm
    ./vim
    ./helix
    ./vscode
  ];
}
