{lib, config, ...}:
{
  options.shell.editorconfig.enable = lib.mkEnableOption "editorconfig";
  
  config = lib.mkIf config.shell.editorconfig.enable {
    home-manager.users.${config.user} = {
      editorconfig = {
        enable = true;

        settings = {
          "*" = {
          end_of_line = "lf";
          insert_final_newline = true;
          charset = "utf-8";
          indent_style = "space";
          indent_size = 2;
          };
        };
      };
    };
  };
}
